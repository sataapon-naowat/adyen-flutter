import Foundation
@_spi(AdyenInternal) import Adyen
import AdyenNetworking

// TODO: Add config:
// 1) Add Info.plist for adding photo library usage description
// 2) Add url scheme
// 3) Add AppDelegate redirect

class CheckoutPlatformApi: CheckoutPlatformInterface {
    private let configurationMapper = ConfigurationMapper()
    private let dropInFlutterApi: DropInFlutterInterface
    private let componentFlutterApi: ComponentFlutterInterface
    private let sessionHolder: SessionHolder

    init(
        dropInFlutterApi: DropInFlutterInterface,
        componentFlutterApi: ComponentFlutterInterface,
        sessionHolder: SessionHolder
    ) {
        self.dropInFlutterApi = dropInFlutterApi
        self.componentFlutterApi = componentFlutterApi
        self.sessionHolder = sessionHolder
    }

    func createSession(
        sessionId: String,
        sessionData: String,
        configuration: Any?,
        completion: @escaping (Result<SessionDTO, Error>) -> Void
    ) {
        do {
            // TODO: Let's plan a generic configuration mapping for creating a session.
            switch configuration {
            case is DropInConfigurationDTO:
                try createSessionForDropIn(configuration as! DropInConfigurationDTO, sessionId, sessionData, completion)
            case is CardComponentConfigurationDTO:
                try createSessionForCardComponent(configuration as! CardComponentConfigurationDTO, sessionId, sessionData, completion)
            case .none, .some:
                completion(Result.failure(PlatformError(errorDescription: "Configuration is not valid")))
            }
        } catch {
            completion(Result.failure(error))
        }
    }

    func getReturnUrl(completion: @escaping (Result<String, Error>) -> Void) {
        completion(Result.failure(PlatformError(errorDescription: "Please use your app url type instead of this method.")))
    }

    func enableConsoleLogging(loggingEnabled: Bool) {
        AdyenLogging.isEnabled = loggingEnabled
    }

    private func createSessionForDropIn(
        _ configuration: DropInConfigurationDTO,
        _ sessionId: String,
        _ sessionData: String,
        _ completion: @escaping (Result<SessionDTO, Error>) -> Void
    ) throws {
        let adyenContext = try configuration.createAdyenContext()
        let sessionDelegate = DropInSessionsDelegate(viewController: getViewController(), dropInFlutterApi: dropInFlutterApi)
        let sessionPresentationDelegate = DropInSessionsPresentationDelegate()
        requestAndSetSession(
            adyenContext,
            sessionId,
            sessionData,
            sessionDelegate,
            sessionPresentationDelegate,
            completion
        )
    }

    private func createSessionForCardComponent(
        _ configuration: CardComponentConfigurationDTO,
        _ sessionId: String,
        _ sessionData: String,
        _ completion: @escaping (Result<SessionDTO, Error>) -> Void
    ) throws {
        let adyenContext = try configuration.createAdyenContext()
        let sessionDelegate = CardSessionFlowDelegate(componentFlutterApi: componentFlutterApi)
        let sessionPresentationDelegate = CardPresentationDelegate(topViewController: getViewController())
        requestAndSetSession(
            adyenContext,
            sessionId,
            sessionData,
            sessionDelegate,
            sessionPresentationDelegate,
            completion
        )
    }

    private func requestAndSetSession(
        _ adyenContext: AdyenContext,
        _ sessionId: String,
        _ sessionData: String,
        _ sessionDelegate: AdyenSessionDelegate,
        _ sessionPresentationDelegate: PresentationDelegate,
        _ completion: @escaping (Result<SessionDTO, Error>) -> Void
    ) {
        let sessionConfiguration = AdyenSession.Configuration(sessionIdentifier: sessionId,
                                                              initialSessionData: sessionData,
                                                              context: adyenContext,
                                                              actionComponent: .init())
        AdyenSession.initialize(with: sessionConfiguration,
                                delegate: sessionDelegate,
                                presentationDelegate: sessionPresentationDelegate) { [weak self] result in
            switch result {
            case let .success(session):
                // TODO: For a later version - We need to return the actual session and removing the session holder when the session is codable.
                self?.sessionHolder.setup(session: session, sessionPresentationDelegate: sessionPresentationDelegate, sessionDelegate: sessionDelegate)
                // TODO: serialize paymentMethods
                completion(Result.success(SessionDTO(id: sessionId,
                                                     sessionData: sessionData,
                                                     paymentMethodsJson: "")))
            case let .failure(error):
                completion(Result.failure(error))
            }
        }
    }

    private func getViewController() -> UIViewController? {
        var rootViewController = UIApplication.shared.adyen.mainKeyWindow?.rootViewController
        while let presentedViewController = rootViewController?.presentedViewController {
            let type = String(describing: type(of: presentedViewController))
            // TODO: - We need to discuss how the SDK should react if a DropInNavigationController is already displayed
            if type == "DropInNavigationController" {
                return nil
            } else {
                rootViewController = presentedViewController
            }
        }

        return rootViewController
    }
}
