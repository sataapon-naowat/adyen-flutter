import Adyen

class DropInAdvancedFlowStoredPaymentMethodsDelegate : StoredPaymentMethodsDelegate {
    private let checkoutFlutterApi: CheckoutFlutterApi
    private var completionHandler: ((Bool) -> Void)?
    
    init(checkoutFlutterApi: CheckoutFlutterApi) {
        self.checkoutFlutterApi = checkoutFlutterApi
    }
    
    internal func disable(storedPaymentMethod: StoredPaymentMethod, completion: @escaping (Bool) -> Void) {
        completionHandler = completion
        let platformCommunicationModel = PlatformCommunicationModel(type: PlatformCommunicationType.deleteStoredPaymentMethod, data: storedPaymentMethod.identifier)
        checkoutFlutterApi.onDropInAdvancedFlowPlatformCommunication(platformCommunicationModel: platformCommunicationModel, completion: {})
    }
    
    func handleDisableResult(isSuccessfullyRemoved: Bool) {
        completionHandler?(isSuccessfullyRemoved)
    }
}
