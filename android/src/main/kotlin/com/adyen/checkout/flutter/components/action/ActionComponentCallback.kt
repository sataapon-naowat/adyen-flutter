package com.adyen.checkout.flutter.components.action

import ComponentCommunicationModel
import ComponentFlutterInterface
import PaymentResultDTO
import PaymentResultEnum
import com.adyen.checkout.components.core.ActionComponentCallback
import com.adyen.checkout.components.core.ActionComponentData
import com.adyen.checkout.components.core.ComponentError

internal class ActionComponentCallback(
    private val componentFlutterApi: ComponentFlutterInterface,
    private val componentId: String,
    private val hideLoadingBottomSheet: () -> Unit,
) : ActionComponentCallback {
    override fun onAdditionalDetails(actionComponentData: ActionComponentData) {
        hideLoadingBottomSheet()
        val data = ActionComponentData.SERIALIZER.serialize(actionComponentData).toString()
        val model =
            ComponentCommunicationModel(
                type = ComponentCommunicationType.ADDITIONALDETAILS,
                componentId = componentId,
                data = data,
            )
        componentFlutterApi.onComponentCommunication(model) {}
    }

    override fun onError(componentError: ComponentError) {
        hideLoadingBottomSheet()
        val type: PaymentResultEnum =
            when (componentError.exception) {
                is com.adyen.checkout.core.exception.CancellationException -> PaymentResultEnum.CANCELLEDBYUSER
                else -> PaymentResultEnum.ERROR
            }
        val model =
            ComponentCommunicationModel(
                type = ComponentCommunicationType.RESULT,
                componentId = componentId,
                paymentResult = PaymentResultDTO(type, componentError.errorMessage),
            )
        componentFlutterApi.onComponentCommunication(model) {}
    }
}
