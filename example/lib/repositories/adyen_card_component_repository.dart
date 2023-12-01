import 'dart:convert';

import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout_example/config.dart';
import 'package:adyen_checkout_example/network/models/amount_network_model.dart';
import 'package:adyen_checkout_example/network/models/payment_methods_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/payment_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/session_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/session_response_network_model.dart';
import 'package:adyen_checkout_example/repositories/adyen_base_repository.dart';

class AdyenCardComponentRepository extends AdyenBaseRepository {
  AdyenCardComponentRepository({
    required super.adyenCheckout,
    required super.service,
  });

  Future<SessionResponseNetworkModel> createSession() async {
    String returnUrl = await determineBaseReturnUrl();
    returnUrl += "/card";
    SessionRequestNetworkModel sessionRequestNetworkModel =
        SessionRequestNetworkModel(
      merchantAccount: Config.merchantAccount,
      amount: AmountNetworkModel(
        currency: Config.amount.currency,
        value: Config.amount.value,
      ),
      returnUrl: returnUrl,
      reference:
          "flutter-session-test_${DateTime.now().millisecondsSinceEpoch}",
      countryCode: Config.countryCode,
      shopperLocale: Config.shopperLocale,
      shopperReference: Config.shopperReference,
      // storePaymentMethodMode:
      //     StorePaymentMethodMode.enabled.storePaymentMethodModeString,
      // recurringProcessingModel:
      //     RecurringProcessingModel.cardOnFile.recurringModelString,
      shopperInteraction:
          ShopperInteractionModel.ecommerce.shopperInteractionModelString,
      channel: determineChannel(),
    );

    return await service.createSession(
      sessionRequestNetworkModel,
      Config.environment,
    );
  }

  Future<String> fetchPaymentMethods() async {
    return await service.fetchPaymentMethods(PaymentMethodsRequestNetworkModel(
      merchantAccount: Config.merchantAccount,
      countryCode: Config.countryCode,
      channel: determineChannel(),
      shopperReference: Config.shopperReference,
    ));
  }

  Future<PaymentFlowOutcome> postPayments(String paymentComponentJson) async {
    String returnUrl = await determineBaseReturnUrl();
    returnUrl += "/card";
    PaymentsRequestData paymentsRequestData = PaymentsRequestData(
      merchantAccount: Config.merchantAccount,
      shopperReference: Config.shopperReference,
      reference: "flutter-test_${DateTime.now().millisecondsSinceEpoch}",
      returnUrl: returnUrl,
      amount: AmountNetworkModel(
        value: Config.amount.value,
        currency: Config.amount.currency,
      ),
      countryCode: Config.countryCode,
      channel: determineChannel(),
      additionalData: AdditionalData(allow3DS2: true, executeThreeD: true),
      threeDS2RequestData: ThreeDS2RequestDataRequest(),
      threeDSAuthenticationOnly: false,
      recurringProcessingModel: RecurringProcessingModel.cardOnFile,
      shopperInteraction:
          ShopperInteractionModel.ecommerce.shopperInteractionModelString,
    );

    Map<String, dynamic> mergedJson = <String, dynamic>{};
    mergedJson.addAll(jsonDecode(paymentComponentJson));
    mergedJson.addAll(paymentsRequestData.toJson());
    final response = await service.postPayments(mergedJson);
    return paymentFlowOutcomeHandler.handleResponse(response);
  }

  Future<PaymentFlowOutcome> postPaymentsDetails(
      String additionalDetails) async {
    final response =
        await service.postPaymentsDetails(jsonDecode(additionalDetails));
    return paymentFlowOutcomeHandler.handleResponse(response);
  }

  Future<bool> deleteStoredPaymentMethod(String storedPaymentMethodId) async {
    return await service.deleteStoredPaymentMethod(
      storedPaymentMethodId: storedPaymentMethodId,
      merchantAccount: Config.merchantAccount,
      shopperReference: Config.shopperReference,
    );
  }
}
