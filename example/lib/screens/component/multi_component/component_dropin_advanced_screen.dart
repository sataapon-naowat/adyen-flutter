// ignore_for_file: unused_local_variable

import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout_example/config.dart';
import 'package:adyen_checkout_example/repositories/adyen_drop_in_repository.dart';
import 'package:adyen_checkout_example/utils/dialog_builder.dart';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class DropInComponentAdvancedScreen extends StatelessWidget {
  const DropInComponentAdvancedScreen({
    required this.repository,
    super.key,
  });

  final AdyenDropInRepository repository;

  @override
  Widget build(BuildContext context) {
    final AdvancedCheckout advancedCheckout = AdvancedCheckout(
      onSubmit: repository.onSubmit,
      onAdditionalDetails: repository.onAdditionalDetails,
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text('Adyen combination')),
        body: SafeArea(
          child: FutureBuilder<Map<String, dynamic>>(
            future: repository.fetchPaymentMethods(),
            builder: (BuildContext context,
                AsyncSnapshot<Map<String, dynamic>> snapshot) {
              if (snapshot.data == null) {
                return const SizedBox.shrink();
              } else {
                return SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Column(
                    children: [
                      _buildCardsBuyButton(
                        context,
                        snapshot.data!,
                        advancedCheckout,
                      ),
                      _buildAppleOrGooglePayWidget(
                        context,
                        snapshot.data!,
                        advancedCheckout,
                      )
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }

  Container _buildCardsBuyButton(
    BuildContext context,
    Map<String, dynamic> paymentMethods,
    AdvancedCheckout advancedCheckout,
  ) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      height: 80,
      width: double.infinity,
      child: TextButton(
        style: ButtonStyle(
          shape: WidgetStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          )),
          backgroundColor: const WidgetStatePropertyAll<Color>(Colors.black),
        ),
        onPressed: () => startDropInAdvancedFlow(
          context,
          paymentMethods,
          advancedCheckout,
        ),
        child: const Text(
          "Buy with Card",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildAppleOrGooglePayWidget(
    BuildContext context,
    Map<String, dynamic> paymentMethods,
    AdvancedCheckout advancedCheckout,
  ) {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        final googlePayPaymentMethod =
            _extractGooglePayPaymentMethod(paymentMethods);
        return _buildAdyenGooglePayAdvancedComponent(
          context,
          paymentMethods,
          advancedCheckout,
        );
      case TargetPlatform.iOS:
        final applePayPaymentMethod =
            _extractApplePayPaymentMethod(paymentMethods);
        return _buildAdyenApplePayAdvancedComponent(
          context,
          applePayPaymentMethod,
          advancedCheckout,
        );
      default:
        throw Exception("Unsupported platform");
    }
  }

  Widget _buildAdyenGooglePayAdvancedComponent(
    BuildContext context,
    Map<String, dynamic> paymentMethod,
    AdvancedCheckout advancedCheckout,
  ) {
    final GooglePayComponentConfiguration googlePayComponentConfiguration =
        GooglePayComponentConfiguration(
      environment: Config.environment,
      clientKey: Config.clientKey,
      countryCode: Config.countryCode,
      amount: Config.amount,
      googlePayConfiguration: const GooglePayConfiguration(
        googlePayEnvironment: Config.googlePayEnvironment,
      ),
    );

    final GooglePayButtonStyle googlePayButtonStyle = GooglePayButtonStyle(
      theme: GooglePayButtonTheme.dark,
      type: GooglePayButtonType.buy,
      cornerRadius: 4,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: AdyenGooglePayComponent(
        configuration: googlePayComponentConfiguration,
        paymentMethod: paymentMethod,
        checkout: advancedCheckout,
        style: googlePayButtonStyle,
        loadingIndicator: const CircularProgressIndicator(),
        width: double.infinity,
        onPaymentResult: (paymentResult) {
          Navigator.pop(context);
          DialogBuilder.showPaymentResultDialog(paymentResult, context);
        },
      ),
    );
  }

  Widget _buildAdyenApplePayAdvancedComponent(
    BuildContext context,
    Map<String, dynamic> paymentMethod,
    AdvancedCheckout advancedCheckout,
  ) {
    final ApplePayComponentConfiguration applePayComponentConfiguration =
        ApplePayComponentConfiguration(
      environment: Config.environment,
      clientKey: Config.clientKey,
      countryCode: Config.countryCode,
      amount: Config.amount,
      applePayConfiguration: _createApplePayConfiguration(),
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: AdyenApplePayComponent(
        configuration: applePayComponentConfiguration,
        paymentMethod: paymentMethod,
        checkout: advancedCheckout,
        loadingIndicator: const CircularProgressIndicator(),
        style: ApplePayButtonStyle(
          theme: ApplePayButtonTheme.black,
          type: ApplePayButtonType.buy,
        ),
        width: double.infinity,
        height: 48,
        onPaymentResult: (paymentResult) {
          DialogBuilder.showPaymentResultDialog(paymentResult, context);
        },
      ),
    );
  }

  ApplePayConfiguration _createApplePayConfiguration() {
    return ApplePayConfiguration(
      merchantId: Config.merchantId,
      merchantName: Config.merchantName,
      allowOnboarding: true,
      applePaySummaryItems: [
        ApplePaySummaryItem(
          label: "Total",
          amount: Config.amount,
          type: ApplePaySummaryItemType.definite,
        ),
      ],
    );
  }

  Future<void> startDropInAdvancedFlow(
    BuildContext context,
    Map<String, dynamic> paymentMethods,
    AdvancedCheckout advancedCheckout,
  ) async {
    try {
      const CardConfiguration cardConfiguration = CardConfiguration(
        showStorePaymentField: false,
      );

      final DropInConfiguration dropInConfiguration = DropInConfiguration(
        environment: Config.environment,
        clientKey: Config.clientKey,
        countryCode: Config.countryCode,
        shopperLocale: Config.shopperLocale,
        cardConfiguration: cardConfiguration,
        skipListWhenSinglePaymentMethod: true,
      );

      final cardPaymentMethod = _extractSchemePaymentMethod(paymentMethods);
      Map<String, dynamic> filteredPaymentMethods = {
        "paymentMethods": [cardPaymentMethod]
      };

      final paymentResult = await AdyenCheckout.advanced.startDropIn(
        dropInConfiguration: dropInConfiguration,
        paymentMethods: filteredPaymentMethods,
        checkout: advancedCheckout,
      );

      if (context.mounted) {
        DialogBuilder.showPaymentResultDialog(paymentResult, context);
      }
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Map<String, dynamic> _extractApplePayPaymentMethod(
      Map<String, dynamic> paymentMethods) {
    if (paymentMethods.isEmpty) {
      return <String, String>{};
    }

    return paymentMethods["paymentMethods"].firstWhere(
      (paymentMethod) => paymentMethod["type"] == "applepay",
      orElse: () => throw Exception("Apple pay payment method not provided"),
    );
  }

  Map<String, dynamic> _extractGooglePayPaymentMethod(
      Map<String, dynamic> paymentMethods) {
    if (paymentMethods.isEmpty) {
      return <String, String>{};
    }

    return paymentMethods["paymentMethods"].firstWhere(
      (paymentMethod) => paymentMethod["type"] == "googlepay",
      orElse: () => throw Exception("Google pay payment method not provided"),
    );
  }

  Map<String, dynamic> _extractSchemePaymentMethod(
      Map<String, dynamic> paymentMethods) {
    List paymentMethodList = paymentMethods["paymentMethods"] as List;
    Map<String, dynamic>? paymentMethod = paymentMethodList
        .firstWhereOrNull((paymentMethod) => paymentMethod["type"] == "scheme");
    return paymentMethod ?? <String, String>{};
  }
}
