package com.adyen.checkout.flutter.components.action

import ActionComponentConfigurationDTO
import ComponentCommunicationModel
import ComponentFlutterInterface
import PaymentResultDTO
import androidx.fragment.app.FragmentActivity
import com.adyen.checkout.action.core.GenericActionComponent
import com.adyen.checkout.action.core.internal.ActionHandlingComponent
import com.adyen.checkout.components.core.CheckoutConfiguration
import com.adyen.checkout.components.core.action.Action
import com.adyen.checkout.flutter.utils.ConfigurationMapper.mapToCheckoutConfiguration
import org.json.JSONObject
import java.util.UUID

internal class ActionComponentManager(
    private val activity: FragmentActivity,
    private val componentFlutterApi: ComponentFlutterInterface,
    private val assignCurrentComponent: (ActionHandlingComponent?) -> Unit,
) {
    private var componentId: String? = null

    companion object {
        var component: GenericActionComponent? = null
    }

    fun handleAction(
        actionComponentConfigurationDTO: ActionComponentConfigurationDTO,
        componentId: String,
        actionResponse: Map<String?, Any?>?
    ) {
        try {
            if (actionResponse == null) {
                sendErrorToFlutterLayer(componentId, "Action response not valid.")
                return
            }

            val checkoutConfiguration = actionComponentConfigurationDTO.mapToCheckoutConfiguration()
            val action = Action.SERIALIZER.deserialize(JSONObject(actionResponse))
            component = createActionComponent(checkoutConfiguration, componentId)
            this.componentId = componentId
            if (component?.canHandleAction(action) == true) {
                assignCurrentComponent(component)
                ActionComponentLoadingBottomSheet.show(activity.supportFragmentManager)
                component?.handleAction(action, activity)
            } else {
                sendErrorToFlutterLayer(componentId, "Action component cannot handle action response.")
                reset()
            }
        } catch (exception: Exception) {
            sendErrorToFlutterLayer(componentId, exception.message ?: "Action handling failed.")
            reset()
        }
    }

    fun onDispose(componentId: String) {
        if (componentId == this.componentId) {
            reset()
        }
    }

    private fun createActionComponent(
        checkoutConfiguration: CheckoutConfiguration,
        componentId: String
    ): GenericActionComponent {
        return GenericActionComponent.PROVIDER.get(
            activity,
            checkoutConfiguration,
            ActionComponentCallback(
                componentFlutterApi,
                componentId,
                ::hideLoadingBottomSheet,
            ),
            UUID.randomUUID().toString()
        )
    }

    private fun sendErrorToFlutterLayer(
        componentId: String,
        errorMessage: String
    ) {
        val model =
            ComponentCommunicationModel(
                type = ComponentCommunicationType.RESULT,
                componentId = componentId,
                paymentResult = PaymentResultDTO(PaymentResultEnum.ERROR, errorMessage),
            )
        componentFlutterApi.onComponentCommunication(model) {}
    }

    private fun hideLoadingBottomSheet() = ActionComponentLoadingBottomSheet.hide(activity.supportFragmentManager)

    private fun reset() {
        componentId = null
        component = null
    }
}
