package com.adyen.checkout.flutter.components.googlepay

import ComponentCommunicationModel
import ComponentFlutterInterface
import InstantPaymentConfigurationDTO
import InstantPaymentSetupResultDTO
import android.content.Intent
import androidx.fragment.app.FragmentActivity
import com.adyen.checkout.action.core.internal.ActionHandlingComponent
import com.adyen.checkout.components.core.CheckoutConfiguration
import com.adyen.checkout.components.core.ComponentAvailableCallback
import com.adyen.checkout.components.core.Order
import com.adyen.checkout.components.core.PaymentMethod
import com.adyen.checkout.components.core.action.Action
import com.adyen.checkout.flutter.components.googlepay.advanced.GooglePayAdvancedCallback
import com.adyen.checkout.flutter.components.googlepay.session.GooglePaySessionCallback
import com.adyen.checkout.flutter.session.SessionHolder
import com.adyen.checkout.flutter.utils.ConfigurationMapper.mapToCheckoutConfiguration
import com.adyen.checkout.flutter.utils.Constants
import com.adyen.checkout.googlepay.GooglePayComponent
import com.adyen.checkout.sessions.core.CheckoutSession
import com.adyen.checkout.sessions.core.SessionSetupResponse
import java.lang.Exception
import java.util.UUID

class GooglePayComponentManager(
    private val activity: FragmentActivity,
    private val sessionHolder: SessionHolder,
    private val componentFlutterInterface: ComponentFlutterInterface,
    private val assignCurrentComponent: (ActionHandlingComponent?) -> Unit,
) : ComponentAvailableCallback {
    private var componentId: String? = null
    private var checkoutConfiguration: CheckoutConfiguration? = null
    private var setupCallback: ((Result<InstantPaymentSetupResultDTO>) -> Unit)? = null

    companion object {
        internal var component: GooglePayComponent? = null
    }

    override fun onAvailabilityResult(
        isAvailable: Boolean,
        paymentMethod: PaymentMethod
    ) {
        val checkoutConfiguration = checkoutConfiguration
        val componentId = componentId

        if (!isAvailable) {
            setupCallback?.invoke(Result.failure(Exception("Google Pay is not available")))
            return
        }

        if (checkoutConfiguration == null) {
            setupCallback?.invoke(Result.failure(Exception("Google Pay configuration is missing")))
            return
        }

        if (componentId == null) {
            setupCallback?.invoke(Result.failure(Exception("Google Pay component id is missing")))
            return
        }

        setupGooglePayComponent(checkoutConfiguration, componentId, paymentMethod)
    }

    fun initialize(
        paymentMethod: PaymentMethod,
        componentId: String,
        instantPaymentComponentConfigurationDTO: InstantPaymentConfigurationDTO,
        googlePaySetupCallback: (Result<InstantPaymentSetupResultDTO>) -> Unit
    ) {
        if (!GooglePayComponent.PROVIDER.isPaymentMethodSupported(paymentMethod)) {
            googlePaySetupCallback(
                Result.success(
                    InstantPaymentSetupResultDTO(
                        instantPaymentComponentConfigurationDTO.instantPaymentType,
                        false
                    )
                )
            )
        }
        val checkoutConfiguration = instantPaymentComponentConfigurationDTO.mapToCheckoutConfiguration()
        this.componentId = componentId
        this.checkoutConfiguration = checkoutConfiguration
        this.setupCallback = googlePaySetupCallback
        GooglePayComponent.PROVIDER.isAvailable(
            activity.application,
            paymentMethod,
            checkoutConfiguration,
            this,
        )
    }

    fun start() {
        (component as? GooglePayComponent?)?.let {
            assignCurrentComponent(it)
            it.startGooglePayScreen(activity, Constants.GOOGLE_PAY_COMPONENT_REQUEST_CODE)
        }
    }

    fun handleGooglePayActivityResult(
        resultCode: Int,
        data: Intent?
    ) = component?.handleActivityResult(resultCode, data)

    fun onDispose(componentId: String) {
        if (componentId == this.componentId) {
            reset()
        }
    }

    private fun setupGooglePayComponent(
        checkoutConfiguration: CheckoutConfiguration,
        componentId: String,
        paymentMethod: PaymentMethod
    ) {
        val googlePayComponent =
            when (componentId) {
                Constants.GOOGLE_PAY_SESSION_COMPONENT_KEY ->
                    createGooglePaySessionComponent(
                        checkoutConfiguration,
                        componentId,
                        paymentMethod
                    )

                Constants.GOOGLE_PAY_ADVANCED_COMPONENT_KEY ->
                    createGooglePayAdvancedComponent(
                        checkoutConfiguration,
                        componentId,
                        paymentMethod
                    )

                else -> null
            }

        if (googlePayComponent == null) {
            setupCallback?.invoke(Result.failure(Exception("Google Pay setup failed")))
            return
        }

        component = googlePayComponent
        val allowedPaymentMethods = googlePayComponent.getGooglePayButtonParameters().allowedPaymentMethods
        setupCallback?.invoke(
            Result.success(
                InstantPaymentSetupResultDTO(
                    InstantPaymentType.GOOGLEPAY,
                    true,
                    allowedPaymentMethods
                )
            )
        )
    }

    private fun createGooglePaySessionComponent(
        checkoutConfiguration: CheckoutConfiguration,
        componentId: String,
        paymentMethod: PaymentMethod,
    ): GooglePayComponent {
        val sessionSetupResponse = SessionSetupResponse.SERIALIZER.deserialize(sessionHolder.sessionSetupResponse)
        val order = sessionHolder.orderResponse?.let { Order.SERIALIZER.deserialize(it) }
        val checkoutSession =
            CheckoutSession(
                sessionSetupResponse,
                order,
                checkoutConfiguration.environment,
                checkoutConfiguration.clientKey
            )
        return GooglePayComponent.PROVIDER.get(
            activity = activity,
            checkoutSession = checkoutSession,
            paymentMethod = paymentMethod,
            checkoutConfiguration = checkoutConfiguration,
            componentCallback =
                GooglePaySessionCallback(
                    componentFlutterInterface,
                    componentId,
                    ::onLoading,
                    ::handleAction,
                    ::hideLoadingBottomSheet
                ),
            key = UUID.randomUUID().toString()
        )
    }

    private fun createGooglePayAdvancedComponent(
        checkoutConfiguration: CheckoutConfiguration,
        componentId: String,
        paymentMethod: PaymentMethod,
    ): GooglePayComponent =
        GooglePayComponent.PROVIDER.get(
            activity = activity,
            paymentMethod = paymentMethod,
            checkoutConfiguration = checkoutConfiguration,
            callback =
                GooglePayAdvancedCallback(
                    componentFlutterInterface,
                    componentId,
                    ::onLoading,
                ),
            key = UUID.randomUUID().toString()
        )

    private fun onLoading(componentId: String) {
        val model =
            ComponentCommunicationModel(
                ComponentCommunicationType.LOADING,
                componentId = componentId,
            )
        componentFlutterInterface.onComponentCommunication(model) {}
    }

    private fun handleAction(action: Action) {
        component?.let {
            it.handleAction(action, activity)
            GooglePayComponentLoadingBottomSheet.show(activity.supportFragmentManager)
        }
    }

    private fun hideLoadingBottomSheet() = GooglePayComponentLoadingBottomSheet.hide(activity.supportFragmentManager)

    private fun reset() {
        componentId = null
        checkoutConfiguration = null
        setupCallback = null
        component = null
    }
}
