@_spi(AdyenInternal)
import Adyen
import AdyenNetworking
import Flutter
import UIKit

class BaseCardComponent : NSObject, FlutterPlatformView {
    
    let cardComponentConfigurationKey = "cardComponentConfiguration"
    let isStoredPaymentMethodKey = "isStoredPaymentMethod"
    let paymentMethodKey = "paymentMethod"
    let componentIdKey = "componentId"
    let cardComponentConfiguration: CardComponentConfigurationDTO?
    let isStoredPaymentMethod: Bool
    let paymentMethod: String?
    let componentId: String
    let componentFlutterApi: ComponentFlutterInterface
    let componentPlatformApi: ComponentPlatformApi
    var componentWrapperView: ComponentWrapperView?

    var cardComponent: CardComponent?
    
    // MARK: - Initalizers
    
    init(
        frame _: CGRect,
        viewIdentifier _: Int64,
        arguments: NSDictionary,
        binaryMessenger: FlutterBinaryMessenger,
        componentFlutterApi: ComponentFlutterInterface,
        componentPlatformApi: ComponentPlatformApi
    ) {
        self.componentFlutterApi = componentFlutterApi
        self.componentPlatformApi = componentPlatformApi
        cardComponentConfiguration = arguments.value(forKey: cardComponentConfigurationKey) as? CardComponentConfigurationDTO
        paymentMethod = arguments.value(forKey: paymentMethodKey) as? String
        isStoredPaymentMethod = arguments.value(forKey: isStoredPaymentMethodKey) as? Bool ?? false
        componentId = arguments.value(forKey: componentIdKey) as? String ?? ""
        super.init()
        
        setupResizeViewportCallback()
    }
    
    func view() -> UIView {
        return componentWrapperView ?? UITextView()
    }
    
    func getViewController() -> UIViewController? {
        var rootViewController = UIApplication.shared.adyen.mainKeyWindow?.rootViewController
        while let presentedViewController = rootViewController?.presentedViewController {
            rootViewController = presentedViewController
        }

        return rootViewController
    }
    
    func showCardComponent(cardComponent: CardComponent) {
        self.cardComponent = cardComponent
        if isStoredPaymentMethod {
            let storedCardViewController = cardComponent.viewController
            //attachActivityIndicator()
            getViewController()?.presentViewController(storedCardViewController, animated: true)
        } else {
            //getViewController()?.addChild(cardComponent.viewController)
            componentWrapperView = ComponentWrapperView(cardComponent: cardComponent) { [weak self] in
               self?.sendHeightUpdate()
            }
            //cardComponent.viewController.didMove(toParent: getViewController())
        }
    }
    
    
    /*
    func attachActivityIndicator() {
           let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
           activityIndicatorView.color = .gray
           activityIndicatorView.startAnimating()
           componentWrapperView?.addSubview(activityIndicatorView)
           activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
           let leadingConstraint = activityIndicatorView.leadingAnchor.constraint(equalTo: componentWrapperView.leadingAnchor)
           let trailingConstraint = activityIndicatorView.trailingAnchor.constraint(equalTo: componentWrapperView.trailingAnchor)
           let topConstraint = activityIndicatorView.topAnchor.constraint(equalTo: componentWrapperView.topAnchor)
           let bottomConstraint = activityIndicatorView.bottomAnchor.constraint(equalTo: componentWrapperView.bottomAnchor)
           NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
       }
     */
    
    func sendErrorToFlutterLayer(errorMessage: String) {
        let componentCommunicationModel = ComponentCommunicationModel(
            type: ComponentCommunicationType.result,
            componentId: componentId,
            paymentResult: PaymentResultDTO(
                type: PaymentResultEnum.error,
                reason: errorMessage
            )
        )
        componentFlutterApi.onComponentCommunication(
            componentCommunicationModel: componentCommunicationModel,
            completion: { _ in }
        )
    }
    
    func finalizeAndDismiss(
        success: Bool,
        completion: @escaping (() -> Void)
    ) {
        cardComponent?.finalizeIfNeeded(with: success) { [weak self] in
            self?.getViewController()?.dismiss(animated: true, completion: {
                completion()
            })
        }
    }
    
    private func disableNativeScrollingAndBouncing(cardView: UIView) {
        let formView = cardView.subviews[0].subviews[0] as? UIScrollView
        formView?.bounces = false
        formView?.isScrollEnabled = false
        formView?.alwaysBounceVertical = false
        formView?.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupResizeViewportCallback() {
        componentPlatformApi.onUpdateViewHeightCallback = { [weak self] in
            self?.sendHeightUpdate()
        }
    }
    
    private func sendHeightUpdate() {
        //guard let viewHeight = cardComponent?.viewController.preferredContentSize.height else { return }
        //let viewHeight = componentWrapperView?.arrangedSubviews.first?.bounds.height  ?? 0
        var viewHeight = componentWrapperView?.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height ?? 0
        viewHeight += 60
        let roundedViewHeight = Double(round(100 * viewHeight / 100))
        print("size", roundedViewHeight)
        
        let componentCommunicationModel = ComponentCommunicationModel(
            type: ComponentCommunicationType.resize,
            componentId: componentId,
            data: roundedViewHeight
        )
        componentFlutterApi.onComponentCommunication(
            componentCommunicationModel: componentCommunicationModel,
            completion: { _ in }
        )
    }
}
