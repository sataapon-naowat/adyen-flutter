import 'dart:convert';

import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout_example/config.dart';
import 'package:adyen_checkout_example/network/models/amount_network_model.dart';
import 'package:adyen_checkout_example/network/models/payment_methods_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/payment_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/session_request_network_model.dart';
import 'package:adyen_checkout_example/network/models/session_response_network_model.dart';
import 'package:adyen_checkout_example/repositories/adyen_base_repository.dart';

class AdyenGooglePayComponentRepository extends AdyenBaseRepository {
  AdyenGooglePayComponentRepository({
    required super.service,
  });

  Future<SessionCheckout> createSessionCheckout() async {
    final sessionResponse = await fetchSession();
    final cardComponentConfiguration = CardComponentConfiguration(
      environment: Config.environment,
      clientKey: Config.clientKey,
      countryCode: Config.countryCode,
      amount: Config.amount,
      shopperLocale: Config.shopperLocale,
      cardConfiguration: const CardConfiguration(),
    );

    return await AdyenCheckout.session.create(
      sessionId: sessionResponse.id,
      sessionData: sessionResponse.sessionData,
      configuration: cardComponentConfiguration,
    );
  }

  Future<SessionResponseNetworkModel> fetchSession() async {
    String returnUrl = await determineBaseReturnUrl();
    returnUrl += "/googlepay";
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
      channel: determineChannel(),
      authenticationData: {
        "attemptAuthentication" : "always",
        "threeDSRequestData": {
          "nativeThreeDS": "preferred",
        },
      },
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

  Future<PaymentEvent> onSubmit(String paymentComponentJson) async {
    String returnUrl = await determineBaseReturnUrl();
    returnUrl += "/googlePay";
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
      recurringProcessingModel: RecurringProcessingModel.cardOnFile,
      shopperInteraction:
          ShopperInteractionModel.ecommerce.shopperInteractionModelString,
      authenticationData: {
        "threeDSRequestData": {
          "nativeThreeDS": "preferred",
        },
      },
    );

    Map<String, dynamic> mergedJson = <String, dynamic>{};
    mergedJson.addAll(jsonDecode(paymentComponentJson));
    mergedJson.addAll(paymentsRequestData.toJson());
    final response = await service.postPayments(mergedJson);
    return paymentEventHandler.handleResponse(response);
  }

  Future<PaymentEvent> onAdditionalDetails(String additionalDetails) async {
    final response =
        await service.postPaymentsDetails(jsonDecode(additionalDetails));
    return paymentEventHandler.handleResponse(response);
  }

  Future<bool> deleteStoredPaymentMethod(String storedPaymentMethodId) async {
    return await service.deleteStoredPaymentMethod(
      storedPaymentMethodId: storedPaymentMethodId,
      merchantAccount: Config.merchantAccount,
      shopperReference: Config.shopperReference,
    );
  }
}
