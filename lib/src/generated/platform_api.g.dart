// Autogenerated from Pigeon (v11.0.1), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name, unnecessary_import

import 'dart:async';
import 'dart:typed_data' show Float64List, Int32List, Int64List, Uint8List;

import 'package:flutter/foundation.dart' show ReadBuffer, WriteBuffer;
import 'package:flutter/services.dart';

enum Environment {
  test,
  europe,
  unitedStates,
  australia,
  india,
  apse,
}

enum AddressMode {
  full,
  postalCode,
  none,
}

enum CardAuthMethod {
  panOnly,
  cryptogram3DS,
}

enum TotalPriceStatus {
  notCurrentlyKnown,
  estimated,
  finalPrice,
}

enum GooglePayEnvironment {
  test,
  production,
}

enum PaymentResultEnum {
  cancelledByUser,
  error,
  finished,
}

enum PlatformCommunicationType {
  paymentComponent,
  additionalDetails,
  result,
}

enum DropInResultType {
  finished,
  action,
  error,
}

class Session {
  Session({
    required this.id,
    required this.sessionData,
  });

  String id;

  String sessionData;

  Object encode() {
    return <Object?>[
      id,
      sessionData,
    ];
  }

  static Session decode(Object result) {
    result as List<Object?>;
    return Session(
      id: result[0]! as String,
      sessionData: result[1]! as String,
    );
  }
}

class Amount {
  Amount({
    this.currency,
    required this.value,
  });

  String? currency;

  int value;

  Object encode() {
    return <Object?>[
      currency,
      value,
    ];
  }

  static Amount decode(Object result) {
    result as List<Object?>;
    return Amount(
      currency: result[0] as String?,
      value: result[1]! as int,
    );
  }
}

class AnalyticsOptionsDTO {
  AnalyticsOptionsDTO({
    this.enabled,
    this.payload,
  });

  bool? enabled;

  String? payload;

  Object encode() {
    return <Object?>[
      enabled,
      payload,
    ];
  }

  static AnalyticsOptionsDTO decode(Object result) {
    result as List<Object?>;
    return AnalyticsOptionsDTO(
      enabled: result[0] as bool?,
      payload: result[1] as String?,
    );
  }
}

class DropInConfigurationDTO {
  DropInConfigurationDTO({
    required this.environment,
    required this.clientKey,
    required this.countryCode,
    required this.amount,
    this.shopperLocale,
    this.analyticsOptionsDTO,
    this.showPreselectedStoredPaymentMethod,
    this.skipListWhenSinglePaymentMethod,
    this.cardsConfigurationDTO,
    this.applePayConfigurationDTO,
    this.googlePayConfigurationDTO,
  });

  Environment environment;

  String clientKey;

  String countryCode;

  Amount amount;

  String? shopperLocale;

  AnalyticsOptionsDTO? analyticsOptionsDTO;

  bool? showPreselectedStoredPaymentMethod;

  bool? skipListWhenSinglePaymentMethod;

  CardsConfigurationDTO? cardsConfigurationDTO;

  ApplePayConfigurationDTO? applePayConfigurationDTO;

  GooglePayConfigurationDTO? googlePayConfigurationDTO;

  Object encode() {
    return <Object?>[
      environment.index,
      clientKey,
      countryCode,
      amount.encode(),
      shopperLocale,
      analyticsOptionsDTO?.encode(),
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      cardsConfigurationDTO?.encode(),
      applePayConfigurationDTO?.encode(),
      googlePayConfigurationDTO?.encode(),
    ];
  }

  static DropInConfigurationDTO decode(Object result) {
    result as List<Object?>;
    return DropInConfigurationDTO(
      environment: Environment.values[result[0]! as int],
      clientKey: result[1]! as String,
      countryCode: result[2]! as String,
      amount: Amount.decode(result[3]! as List<Object?>),
      shopperLocale: result[4] as String?,
      analyticsOptionsDTO: result[5] != null
          ? AnalyticsOptionsDTO.decode(result[5]! as List<Object?>)
          : null,
      showPreselectedStoredPaymentMethod: result[6] as bool?,
      skipListWhenSinglePaymentMethod: result[7] as bool?,
      cardsConfigurationDTO: result[8] != null
          ? CardsConfigurationDTO.decode(result[8]! as List<Object?>)
          : null,
      applePayConfigurationDTO: result[9] != null
          ? ApplePayConfigurationDTO.decode(result[9]! as List<Object?>)
          : null,
      googlePayConfigurationDTO: result[10] != null
          ? GooglePayConfigurationDTO.decode(result[10]! as List<Object?>)
          : null,
    );
  }
}

class CardsConfigurationDTO {
  CardsConfigurationDTO({
    required this.holderNameRequired,
    required this.addressMode,
    required this.showStorePaymentField,
    required this.showCvcForStoredCard,
    required this.showCvc,
    required this.showKcpField,
    required this.showSocialSecurityNumberField,
    required this.supportedCardTypes,
  });

  bool holderNameRequired;

  AddressMode addressMode;

  bool showStorePaymentField;

  bool showCvcForStoredCard;

  bool showCvc;

  bool showKcpField;

  bool showSocialSecurityNumberField;

  List<String?> supportedCardTypes;

  Object encode() {
    return <Object?>[
      holderNameRequired,
      addressMode.index,
      showStorePaymentField,
      showCvcForStoredCard,
      showCvc,
      showKcpField,
      showSocialSecurityNumberField,
      supportedCardTypes,
    ];
  }

  static CardsConfigurationDTO decode(Object result) {
    result as List<Object?>;
    return CardsConfigurationDTO(
      holderNameRequired: result[0]! as bool,
      addressMode: AddressMode.values[result[1]! as int],
      showStorePaymentField: result[2]! as bool,
      showCvcForStoredCard: result[3]! as bool,
      showCvc: result[4]! as bool,
      showKcpField: result[5]! as bool,
      showSocialSecurityNumberField: result[6]! as bool,
      supportedCardTypes: (result[7] as List<Object?>?)!.cast<String?>(),
    );
  }
}

class ApplePayConfigurationDTO {
  ApplePayConfigurationDTO({
    required this.merchantId,
    required this.merchantName,
    required this.allowOnboarding,
  });

  String merchantId;

  String merchantName;

  bool allowOnboarding;

  Object encode() {
    return <Object?>[
      merchantId,
      merchantName,
      allowOnboarding,
    ];
  }

  static ApplePayConfigurationDTO decode(Object result) {
    result as List<Object?>;
    return ApplePayConfigurationDTO(
      merchantId: result[0]! as String,
      merchantName: result[1]! as String,
      allowOnboarding: result[2]! as bool,
    );
  }
}

class GooglePayConfigurationDTO {
  GooglePayConfigurationDTO({
    required this.merchantAccount,
    required this.allowedCardNetworks,
    required this.allowedAuthMethods,
    required this.totalPriceStatus,
    required this.allowPrepaidCards,
    required this.billingAddressRequired,
    required this.emailRequired,
    required this.shippingAddressRequired,
    required this.existingPaymentMethodRequired,
    required this.googlePayEnvironment,
  });

  String merchantAccount;

  List<String?> allowedCardNetworks;

  List<String?> allowedAuthMethods;

  TotalPriceStatus totalPriceStatus;

  bool allowPrepaidCards;

  bool billingAddressRequired;

  bool emailRequired;

  bool shippingAddressRequired;

  bool existingPaymentMethodRequired;

  GooglePayEnvironment googlePayEnvironment;

  Object encode() {
    return <Object?>[
      merchantAccount,
      allowedCardNetworks,
      allowedAuthMethods,
      totalPriceStatus.index,
      allowPrepaidCards,
      billingAddressRequired,
      emailRequired,
      shippingAddressRequired,
      existingPaymentMethodRequired,
      googlePayEnvironment.index,
    ];
  }

  static GooglePayConfigurationDTO decode(Object result) {
    result as List<Object?>;
    return GooglePayConfigurationDTO(
      merchantAccount: result[0]! as String,
      allowedCardNetworks: (result[1] as List<Object?>?)!.cast<String?>(),
      allowedAuthMethods: (result[2] as List<Object?>?)!.cast<String?>(),
      totalPriceStatus: TotalPriceStatus.values[result[3]! as int],
      allowPrepaidCards: result[4]! as bool,
      billingAddressRequired: result[5]! as bool,
      emailRequired: result[6]! as bool,
      shippingAddressRequired: result[7]! as bool,
      existingPaymentMethodRequired: result[8]! as bool,
      googlePayEnvironment: GooglePayEnvironment.values[result[9]! as int],
    );
  }
}

class PaymentResult {
  PaymentResult({
    required this.type,
    this.reason,
    this.result,
  });

  PaymentResultEnum type;

  String? reason;

  PaymentResultModel? result;

  Object encode() {
    return <Object?>[
      type.index,
      reason,
      result?.encode(),
    ];
  }

  static PaymentResult decode(Object result) {
    result as List<Object?>;
    return PaymentResult(
      type: PaymentResultEnum.values[result[0]! as int],
      reason: result[1] as String?,
      result: result[2] != null
          ? PaymentResultModel.decode(result[2]! as List<Object?>)
          : null,
    );
  }
}

class PaymentResultModel {
  PaymentResultModel({
    this.sessionId,
    this.sessionData,
    this.resultCode,
    this.order,
  });

  String? sessionId;

  String? sessionData;

  String? resultCode;

  OrderResponseModel? order;

  Object encode() {
    return <Object?>[
      sessionId,
      sessionData,
      resultCode,
      order?.encode(),
    ];
  }

  static PaymentResultModel decode(Object result) {
    result as List<Object?>;
    return PaymentResultModel(
      sessionId: result[0] as String?,
      sessionData: result[1] as String?,
      resultCode: result[2] as String?,
      order: result[3] != null
          ? OrderResponseModel.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class OrderResponseModel {
  OrderResponseModel({
    required this.pspReference,
    required this.orderData,
    this.amount,
    this.remainingAmount,
  });

  String pspReference;

  String orderData;

  Amount? amount;

  Amount? remainingAmount;

  Object encode() {
    return <Object?>[
      pspReference,
      orderData,
      amount?.encode(),
      remainingAmount?.encode(),
    ];
  }

  static OrderResponseModel decode(Object result) {
    result as List<Object?>;
    return OrderResponseModel(
      pspReference: result[0]! as String,
      orderData: result[1]! as String,
      amount: result[2] != null
          ? Amount.decode(result[2]! as List<Object?>)
          : null,
      remainingAmount: result[3] != null
          ? Amount.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class PlatformCommunicationModel {
  PlatformCommunicationModel({
    required this.type,
    this.data,
    this.paymentResult,
  });

  PlatformCommunicationType type;

  String? data;

  PaymentResult? paymentResult;

  Object encode() {
    return <Object?>[
      type.index,
      data,
      paymentResult?.encode(),
    ];
  }

  static PlatformCommunicationModel decode(Object result) {
    result as List<Object?>;
    return PlatformCommunicationModel(
      type: PlatformCommunicationType.values[result[0]! as int],
      data: result[1] as String?,
      paymentResult: result[2] != null
          ? PaymentResult.decode(result[2]! as List<Object?>)
          : null,
    );
  }
}

class DropInResult {
  DropInResult({
    required this.dropInResultType,
    this.result,
    this.actionResponse,
    this.error,
  });

  DropInResultType dropInResultType;

  String? result;

  Map<String?, Object?>? actionResponse;

  DropInError? error;

  Object encode() {
    return <Object?>[
      dropInResultType.index,
      result,
      actionResponse,
      error?.encode(),
    ];
  }

  static DropInResult decode(Object result) {
    result as List<Object?>;
    return DropInResult(
      dropInResultType: DropInResultType.values[result[0]! as int],
      result: result[1] as String?,
      actionResponse: (result[2] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
      error: result[3] != null
          ? DropInError.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class DropInError {
  DropInError({
    this.errorMessage,
    this.reason,
    this.dismissDropIn,
  });

  String? errorMessage;

  String? reason;

  bool? dismissDropIn;

  Object encode() {
    return <Object?>[
      errorMessage,
      reason,
      dismissDropIn,
    ];
  }

  static DropInError decode(Object result) {
    result as List<Object?>;
    return DropInError(
      errorMessage: result[0] as String?,
      reason: result[1] as String?,
      dismissDropIn: result[2] as bool?,
    );
  }
}

class _CheckoutPlatformInterfaceCodec extends StandardMessageCodec {
  const _CheckoutPlatformInterfaceCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Amount) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is AnalyticsOptionsDTO) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is ApplePayConfigurationDTO) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is CardsConfigurationDTO) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is DropInConfigurationDTO) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is DropInError) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is DropInResult) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is GooglePayConfigurationDTO) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is Session) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return Amount.decode(readValue(buffer)!);
      case 129: 
        return AnalyticsOptionsDTO.decode(readValue(buffer)!);
      case 130: 
        return ApplePayConfigurationDTO.decode(readValue(buffer)!);
      case 131: 
        return CardsConfigurationDTO.decode(readValue(buffer)!);
      case 132: 
        return DropInConfigurationDTO.decode(readValue(buffer)!);
      case 133: 
        return DropInError.decode(readValue(buffer)!);
      case 134: 
        return DropInResult.decode(readValue(buffer)!);
      case 135: 
        return GooglePayConfigurationDTO.decode(readValue(buffer)!);
      case 136: 
        return Session.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class CheckoutPlatformInterface {
  /// Constructor for [CheckoutPlatformInterface].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  CheckoutPlatformInterface({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;
  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _CheckoutPlatformInterfaceCodec();

  Future<String> getPlatformVersion() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getPlatformVersion', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<String> getReturnUrl() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.getReturnUrl', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(null) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else if (replyList[0] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyList[0] as String?)!;
    }
  }

  Future<void> startDropInSessionPayment(DropInConfigurationDTO arg_dropInConfigurationDTO, Session arg_session) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startDropInSessionPayment', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_dropInConfigurationDTO, arg_session]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> startDropInAdvancedFlowPayment(DropInConfigurationDTO arg_dropInConfigurationDTO, String arg_paymentMethodsResponse) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startDropInAdvancedFlowPayment', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_dropInConfigurationDTO, arg_paymentMethodsResponse]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> onPaymentsResult(DropInResult arg_paymentsResult) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onPaymentsResult', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_paymentsResult]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }

  Future<void> onPaymentsDetailsResult(DropInResult arg_paymentsDetailsResult) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onPaymentsDetailsResult', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_paymentsDetailsResult]) as List<Object?>?;
    if (replyList == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyList.length > 1) {
      throw PlatformException(
        code: replyList[0]! as String,
        message: replyList[1] as String?,
        details: replyList[2],
      );
    } else {
      return;
    }
  }
}

class _CheckoutFlutterApiCodec extends StandardMessageCodec {
  const _CheckoutFlutterApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is Amount) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is OrderResponseModel) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is PaymentResult) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is PaymentResultModel) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is PlatformCommunicationModel) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return Amount.decode(readValue(buffer)!);
      case 129: 
        return OrderResponseModel.decode(readValue(buffer)!);
      case 130: 
        return PaymentResult.decode(readValue(buffer)!);
      case 131: 
        return PaymentResultModel.decode(readValue(buffer)!);
      case 132: 
        return PlatformCommunicationModel.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class CheckoutFlutterApi {
  static const MessageCodec<Object?> codec = _CheckoutFlutterApiCodec();

  void onDropInSessionResult(PaymentResult sessionPaymentResult);

  void onDropInAdvancedFlowPlatformCommunication(PlatformCommunicationModel platformCommunicationModel);

  static void setup(CheckoutFlutterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionResult', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionResult was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PaymentResult? arg_sessionPaymentResult = (args[0] as PaymentResult?);
          assert(arg_sessionPaymentResult != null,
              'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionResult was null, expected non-null PaymentResult.');
          api.onDropInSessionResult(arg_sessionPaymentResult!);
          return;
        });
      }
    }
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInAdvancedFlowPlatformCommunication', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInAdvancedFlowPlatformCommunication was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PlatformCommunicationModel? arg_platformCommunicationModel = (args[0] as PlatformCommunicationModel?);
          assert(arg_platformCommunicationModel != null,
              'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInAdvancedFlowPlatformCommunication was null, expected non-null PlatformCommunicationModel.');
          api.onDropInAdvancedFlowPlatformCommunication(arg_platformCommunicationModel!);
          return;
        });
      }
    }
  }
}
