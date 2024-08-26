package com.adyen.checkout.flutter.components.view

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import com.adyen.checkout.components.core.internal.Component
import com.adyen.checkout.ui.core.internal.ui.ViewableComponent

class ComponentLoadingBottomSheetViewModel<T>(val component: T) : ViewModel() where T : Component, T : ViewableComponent {
    companion object {
        class ViewModelFactory<T>(
            private val component: T
        ) : ViewModelProvider.Factory where T : Component, T : ViewableComponent {
            @Suppress("UNCHECKED_CAST") // From Android docs: https://developer.android.com/topic/libraries/architecture/viewmodel/viewmodel-factories#kotlin_1
            override fun <T : ViewModel> create(modelClass: Class<T>): T {
                return when {
                    modelClass.isAssignableFrom(
                        ComponentLoadingBottomSheetViewModel::class.java
                    ) -> ComponentLoadingBottomSheetViewModel(component) as T
                    else -> throw IllegalArgumentException("Unknown ViewModel class")
                }
            }
        }
    }
}
