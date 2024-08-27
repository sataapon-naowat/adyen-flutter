package com.adyen.checkout.flutter.components.view

import androidx.lifecycle.ViewModel
import com.adyen.checkout.components.core.internal.Component
import com.adyen.checkout.ui.core.internal.ui.ViewableComponent

class ComponentLoadingBottomSheetViewModel<T> : ViewModel() where T : Component, T : ViewableComponent {
    var component: T? = null

    fun reset() {
        component = null
    }

//    companion object {
//        class ViewModelFactory<T>(
//
//        ) : ViewModelProvider.Factory where T : Component, T : ViewableComponent {
//            // From Android docs: https://developer.android.com/topic/libraries/architecture/viewmodel/viewmodel-factories#kotlin_1
//            @Suppress("UNCHECKED_CAST")
//            override fun <T : ViewModel> create(modelClass: Class<T>): T {
//                return when {
//                    modelClass.isAssignableFrom(
//                        ComponentLoadingBottomSheetViewModel::class.java
//                    ) -> ComponentLoadingBottomSheetViewModel() as T
//
//                    else -> throw IllegalArgumentException("Unknown ViewModel class")
//                }
//            }
//        }
//    }
}
