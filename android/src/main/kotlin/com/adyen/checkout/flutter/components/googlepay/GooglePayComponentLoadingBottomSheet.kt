package com.adyen.checkout.flutter.components.googlepay
import android.os.Bundle
import android.view.View
import androidx.fragment.app.FragmentManager
import com.adyen.checkout.flutter.R
import com.adyen.checkout.flutter.components.view.ComponentLoadingBottomSheet
import com.adyen.checkout.flutter.utils.Constants.Companion.COMPONENT_LOADING_BOTTOM_SHEET_TAG
import com.adyen.checkout.ui.core.AdyenComponentView

internal class GooglePayComponentLoadingBottomSheet : ComponentLoadingBottomSheet() {
    override fun onViewCreated(
        view: View,
        savedInstanceState: Bundle?
    ) {
        GooglePayComponentManager.component?.let {
            view.findViewById<AdyenComponentView>(R.id.adyen_component_view)?.attach(it, viewLifecycleOwner)
            isCancelable = false
        }
    }

    companion object {
        fun show(fragmentManager: FragmentManager) =
            GooglePayComponentLoadingBottomSheet().show(fragmentManager, COMPONENT_LOADING_BOTTOM_SHEET_TAG)

        fun hide(fragmentManager: FragmentManager) = dismissBottomSheet(fragmentManager)
    }
}
