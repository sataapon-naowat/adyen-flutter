package com.adyen.checkout.flutter.components.googlepay.advanced

import ComponentCommunicationModel
import ComponentFlutterInterface
import com.adyen.checkout.components.core.PaymentComponentData
import com.adyen.checkout.flutter.components.base.ComponentAdvancedCallback
import com.adyen.checkout.flutter.utils.Constants
import com.adyen.checkout.googlepay.GooglePayComponentState
import org.json.JSONObject

class GooglePayAdvancedCallback(
    private val componentFlutterApi: ComponentFlutterInterface,
    private val componentId: String,
    private val onLoadingCallback: (String) -> Unit,
) : ComponentAdvancedCallback<GooglePayComponentState>(componentFlutterApi, componentId) {
    override fun onSubmit(state: GooglePayComponentState) {
        onLoadingCallback(componentId)
        val data = PaymentComponentData.SERIALIZER.serialize(state.data)
        val extra = state.paymentData?.toJson()
        val submitData =
            JSONObject().apply {
                put(Constants.ADVANCED_PAYMENT_DATA_KEY, data)
                extra?.let {
                    put(Constants.ADVANCED_EXTRA_DATA_KEY, JSONObject(it))
                }
            }
        val model =
            ComponentCommunicationModel(
                ComponentCommunicationType.ONSUBMIT,
                componentId = componentId,
                data = submitData.toString(),
            )
        componentFlutterApi.onComponentCommunication(model) {}
    }
}
