import Adyen

class ComponentActionDelegate: ActionComponentDelegate {
    private let componentFlutterApi: ComponentFlutterInterface
    private let componentId: String
    private let finalizeAndDismissComponent: (Bool, @escaping (() -> Void)) -> Void
    
    init(
        componentFlutterApi: ComponentFlutterInterface,
        componentId: String,
        finalizeAndDismissComponent: @escaping ((Bool, @escaping (() -> Void)) -> Void)
    ) {
        self.componentFlutterApi = componentFlutterApi
        self.componentId = componentId
        self.finalizeAndDismissComponent = finalizeAndDismissComponent
    }
    
    internal func didProvide(_ data: Adyen.ActionComponentData, from _: Adyen.ActionComponent) {
        do {
            let actionComponentData = ActionComponentDataModel(details: data.details.encodable, paymentData: data.paymentData)
            let actionComponentDataJson = try JSONEncoder().encode(actionComponentData)
            let actionComponentDataString = String(data: actionComponentDataJson, encoding: .utf8)
            let componentCommunicationModel = ComponentCommunicationModel(
                type: ComponentCommunicationType.additionalDetails,
                componentId: componentId,
                data: actionComponentDataString
            )
            componentFlutterApi.onComponentCommunication(
                componentCommunicationModel: componentCommunicationModel,
                completion: { _ in }
            )
        } catch {
            finalizeAndDismissComponent(false) { [weak self] in
                self?.sendErrorToFlutterLayer(error: error)
            }
        }
    }

    internal func didComplete(from _: Adyen.ActionComponent) {
        // Only for voucher payment method - currently not supported.
    }

    internal func didFail(with error: Error, from _: Adyen.ActionComponent) {
        finalizeAndDismissComponent(false) { [weak self] in
            self?.sendErrorToFlutterLayer(error: error)
        }
    }
    
    private func sendErrorToFlutterLayer(error: Error) {
        let type: PaymentResultEnum
        if let componentError = (error as? ComponentError), componentError == ComponentError.cancelled {
            type = PaymentResultEnum.cancelledByUser
        } else {
            type = PaymentResultEnum.error
        }
        let componentCommunicationModel = ComponentCommunicationModel(
            type: ComponentCommunicationType.result,
            componentId: componentId,
            paymentResult: PaymentResultDTO(
                type: type,
                reason: error.localizedDescription
            )
        )
        componentFlutterApi.onComponentCommunication(
            componentCommunicationModel: componentCommunicationModel,
            completion: { _ in }
        )
    }
}
