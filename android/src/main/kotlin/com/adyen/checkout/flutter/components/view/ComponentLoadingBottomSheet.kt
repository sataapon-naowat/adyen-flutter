package com.adyen.checkout.flutter.components.view

import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import androidx.fragment.app.FragmentManager
import com.adyen.checkout.flutter.R
import com.adyen.checkout.flutter.utils.Constants.Companion.COMPONENT_LOADING_BOTTOM_SHEET_TAG
import com.google.android.material.bottomsheet.BottomSheetDialogFragment

abstract class ComponentLoadingBottomSheet : BottomSheetDialogFragment() {
    override fun onCreateView(
        inflater: LayoutInflater,
        container: ViewGroup?,
        savedInstanceState: Bundle?
    ): View? = inflater.inflate(R.layout.component_bottom_sheet_content, container, false)

    override fun onCreateDialog(savedInstanceState: Bundle?) =
        super.onCreateDialog(savedInstanceState).apply {
            window?.setWindowAnimations(
                com.adyen.checkout.ui.core.R.style.AdyenCheckout_BottomSheet_NoWindowEnterDialogAnimation
            )
        }

    companion object {
        fun dismissBottomSheet(fragmentManager: FragmentManager) {
            fragmentManager.findFragmentByTag(COMPONENT_LOADING_BOTTOM_SHEET_TAG)?.let {
                (it as? BottomSheetDialogFragment)?.dismiss()
            }
        }
    }
}
