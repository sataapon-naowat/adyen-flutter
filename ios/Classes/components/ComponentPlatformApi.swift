class ComponentPlatformApi: ComponentPlatformInterface {
    var onUpdateViewHeightCallback: () -> Void = {}
    var onActionCallback: ([String?: Any?]) -> Void = { _ in }
    var onFinishCallback: (PaymentEventDTO) -> Void = { _ in }
    var onErrorCallback: (ErrorDTO?) -> Void = { _ in }
    private let applePayComponentManager: ApplePayComponentManager
    
    init(applePayComponentManager: ApplePayComponentManager) {
        self.applePayComponentManager = applePayComponentManager
    }

    func updateViewHeight(viewId _: Int64) {
        onUpdateViewHeightCallback()
    }

    func onPaymentsResult(paymentsResult: PaymentEventDTO) {
        applePayComponentManager.handlePaymentEvent(paymentEventDTO: paymentsResult)
        handlePaymentEvent(paymentEventDTO: paymentsResult)
    }

    func onPaymentsDetailsResult(paymentsDetailsResult: PaymentEventDTO) {
        handlePaymentEvent(paymentEventDTO: paymentsDetailsResult)
    }

    func isInstantPaymentSupportedByPlatform(
        instantPaymentConfigurationDTO: InstantPaymentConfigurationDTO,
        paymentMethodResponse: String,
        componentId: String,
        completion: @escaping (Result<InstantPaymentSetupResultDTO, Error>) -> Void
    ) {
        switch instantPaymentConfigurationDTO.instantPaymentType {
        case .googlePay:
            return
        case .applePay:
            applePayComponentManager.setUpApplePayIfAvailable(
                instantPaymentComponentConfigurationDTO: instantPaymentConfigurationDTO,
                paymentMethodResponse: paymentMethodResponse,
                componentId: componentId,
                callback: completion
            )
        }
    }

    func onInstantPaymentPressed(instantPaymentType: InstantPaymentType, componentId: String) {
        switch instantPaymentType {
        case .googlePay:
            return
        case .applePay:
            applePayComponentManager.onApplePayComponentPressed(componentId: componentId)
        }
    }

    func onDispose(componentId: String) throws {}

    private func handlePaymentEvent(paymentEventDTO: PaymentEventDTO) {
        switch paymentEventDTO.paymentEventType {
        case .finished:
            onFinishCallback(paymentEventDTO)
        case .action:
            guard let jsonActionResponse = paymentEventDTO.actionResponse else { return }
            onActionCallback(jsonActionResponse)
        case .error:
            onErrorCallback(paymentEventDTO.error)
        }
    }
}
