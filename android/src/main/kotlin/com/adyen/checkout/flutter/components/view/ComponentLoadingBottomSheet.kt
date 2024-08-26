package com.adyen.checkout.flutter.components.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentManager
import androidx.fragment.app.activityViewModels
import androidx.lifecycle.ViewModelProvider
import com.adyen.checkout.components.core.internal.Component
import com.adyen.checkout.flutter.R
import com.adyen.checkout.flutter.utils.Constants.Companion.COMPONENT_LOADING_BOTTOM_SHEET_TAG
import com.adyen.checkout.ui.core.AdyenComponentView
import com.adyen.checkout.ui.core.internal.ui.ViewableComponent
import com.google.android.material.bottomsheet.BottomSheetDialogFragment

class ComponentLoadingBottomSheet<T> : BottomSheetDialogFragment() where T : Component, T : ViewableComponent {
    private val viewModel: ComponentLoadingBottomSheetViewModel<T> by activityViewModels()

    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = inflater.inflate(R.layout.component_bottom_sheet_content, container, false)

    override fun onViewCreated(
        view: View,
        savedInstanceState: Bundle?
    ) {
        view.findViewById<AdyenComponentView>(R.id.adyen_component_view)
            ?.attach(viewModel.component, viewLifecycleOwner)
        isCancelable = false
    }

    override fun onCreateDialog(savedInstanceState: Bundle?) =
        super.onCreateDialog(savedInstanceState).apply {
            window?.setWindowAnimations(
                com.adyen.checkout.ui.core.R.style.AdyenCheckout_BottomSheet_NoWindowEnterDialogAnimation
            )
        }

    companion object {
        fun <T> show(
            activity: FragmentActivity,
            component: T
        ) where T : Component, T : ViewableComponent {
            val factory = ComponentLoadingBottomSheetViewModel.Companion.ViewModelFactory(component)
            ViewModelProvider(activity, factory)[ComponentLoadingBottomSheetViewModel::class.java]
            ComponentLoadingBottomSheet<T>().show(activity.supportFragmentManager, COMPONENT_LOADING_BOTTOM_SHEET_TAG)
        }

        fun hide(fragmentManager: FragmentManager) {
            fragmentManager.findFragmentByTag(COMPONENT_LOADING_BOTTOM_SHEET_TAG)?.let {
                (it as? BottomSheetDialogFragment)?.dismiss()
            }
        }
    }
}
