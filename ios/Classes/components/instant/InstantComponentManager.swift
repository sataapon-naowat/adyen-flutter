import Adyen

class InstantComponentManager {
    private let componentFlutterApi: ComponentFlutterInterface
    private let sessionHolder: SessionHolder
    private var instantComponent: BaseInstantComponent?
    enum Constants {
        static let instantSessionComponentId = "SESSION_COMPONENT"
        static let instantAdvancedComponentId = "ADVANCED_COMPONENT"
    }
    
    init(componentFlutterApi: ComponentFlutterInterface, sessionHolder: SessionHolder) {
        self.componentFlutterApi = componentFlutterApi
        self.sessionHolder = sessionHolder
    }

    func startInstantComponent(
        instantPaymentConfigurationDTO: InstantPaymentConfigurationDTO,
        encodedPaymentMethod: String,
        componentId: String
    ) {
        do {
            let paymentMethod = try JSONDecoder().decode(InstantPaymentMethod.self, from: Data(encodedPaymentMethod.utf8))
            let adyenContext = try instantPaymentConfigurationDTO.createAdyenContext()
            switch componentId {
            case let id where id.contains(Constants.instantAdvancedComponentId):
                instantComponent = InstantAdvancedComponent(
                    componentFlutterApi: componentFlutterApi,
                    paymentMethod: paymentMethod,
                    adyenContext: adyenContext,
                    componentId: componentId
                )

            case let id where id.contains(Constants.instantSessionComponentId):
                instantComponent = InstantSessionComponent(
                    componentFlutterApi: componentFlutterApi,
                    paymentMethod: paymentMethod,
                    adyenContext: adyenContext,
                    sessionHolder: sessionHolder,
                    componentId: componentId
                )

            default:
                throw PlatformError(errorDescription: "Instant component not available for payment flow.")
            }
            instantComponent?.initiatePayment()
        } catch {
            let componentCommunicationModel = ComponentCommunicationModel(
                type: ComponentCommunicationType.result,
                componentId: componentId,
                paymentResult: PaymentResultDTO(
                    type: PaymentResultEnum.error,
                    reason: error.localizedDescription
                )
            )
            self.componentFlutterApi.onComponentCommunication(
                componentCommunicationModel: componentCommunicationModel,
                completion: { _ in }
            )
        }
    }
    
    func handlePaymentEvent(paymentEventDTO: PaymentEventDTO) {
        if let instantAdvancedComponent = instantComponent as? InstantAdvancedComponent {
            instantAdvancedComponent.handlePaymentEvent(paymentEventDTO: paymentEventDTO)
        }
    }
    
    func onDispose() {
        instantComponent?.onDispose()
        instantComponent = nil
    }
}
