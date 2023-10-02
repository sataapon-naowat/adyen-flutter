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

enum CashAppPayEnvironment {
  sandbox,
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
  deleteStoredPaymentMethod,
}

enum DropInResultType {
  finished,
  action,
  error,
}

enum FieldVisibility {
  show,
  hide,
}

class SessionDTO {
  SessionDTO({
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

  static SessionDTO decode(Object result) {
    result as List<Object?>;
    return SessionDTO(
      id: result[0]! as String,
      sessionData: result[1]! as String,
    );
  }
}

class AmountDTO {
  AmountDTO({
    required this.currency,
    required this.value,
  });

  String currency;

  int value;

  Object encode() {
    return <Object?>[
      currency,
      value,
    ];
  }

  static AmountDTO decode(Object result) {
    result as List<Object?>;
    return AmountDTO(
      currency: result[0]! as String,
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
    required this.shopperLocale,
    this.cardsConfigurationDTO,
    this.applePayConfigurationDTO,
    this.googlePayConfigurationDTO,
    this.cashAppPayConfigurationDTO,
    this.analyticsOptionsDTO,
    required this.showPreselectedStoredPaymentMethod,
    required this.skipListWhenSinglePaymentMethod,
    required this.isRemoveStoredPaymentMethodEnabled,
  });

  Environment environment;

  String clientKey;

  String countryCode;

  AmountDTO amount;

  String shopperLocale;

  CardsConfigurationDTO? cardsConfigurationDTO;

  ApplePayConfigurationDTO? applePayConfigurationDTO;

  GooglePayConfigurationDTO? googlePayConfigurationDTO;

  CashAppPayConfigurationDTO? cashAppPayConfigurationDTO;

  AnalyticsOptionsDTO? analyticsOptionsDTO;

  bool showPreselectedStoredPaymentMethod;

  bool skipListWhenSinglePaymentMethod;

  bool isRemoveStoredPaymentMethodEnabled;

  Object encode() {
    return <Object?>[
      environment.index,
      clientKey,
      countryCode,
      amount.encode(),
      shopperLocale,
      cardsConfigurationDTO?.encode(),
      applePayConfigurationDTO?.encode(),
      googlePayConfigurationDTO?.encode(),
      cashAppPayConfigurationDTO?.encode(),
      analyticsOptionsDTO?.encode(),
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      isRemoveStoredPaymentMethodEnabled,
    ];
  }

  static DropInConfigurationDTO decode(Object result) {
    result as List<Object?>;
    return DropInConfigurationDTO(
      environment: Environment.values[result[0]! as int],
      clientKey: result[1]! as String,
      countryCode: result[2]! as String,
      amount: AmountDTO.decode(result[3]! as List<Object?>),
      shopperLocale: result[4]! as String,
      cardsConfigurationDTO: result[5] != null
          ? CardsConfigurationDTO.decode(result[5]! as List<Object?>)
          : null,
      applePayConfigurationDTO: result[6] != null
          ? ApplePayConfigurationDTO.decode(result[6]! as List<Object?>)
          : null,
      googlePayConfigurationDTO: result[7] != null
          ? GooglePayConfigurationDTO.decode(result[7]! as List<Object?>)
          : null,
      cashAppPayConfigurationDTO: result[8] != null
          ? CashAppPayConfigurationDTO.decode(result[8]! as List<Object?>)
          : null,
      analyticsOptionsDTO: result[9] != null
          ? AnalyticsOptionsDTO.decode(result[9]! as List<Object?>)
          : null,
      showPreselectedStoredPaymentMethod: result[10]! as bool,
      skipListWhenSinglePaymentMethod: result[11]! as bool,
      isRemoveStoredPaymentMethodEnabled: result[12]! as bool,
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
    required this.kcpFieldVisibility,
    required this.socialSecurityNumberFieldVisibility,
    required this.supportedCardTypes,
  });

  bool holderNameRequired;

  AddressMode addressMode;

  bool showStorePaymentField;

  bool showCvcForStoredCard;

  bool showCvc;

  FieldVisibility kcpFieldVisibility;

  FieldVisibility socialSecurityNumberFieldVisibility;

  List<String?> supportedCardTypes;

  Object encode() {
    return <Object?>[
      holderNameRequired,
      addressMode.index,
      showStorePaymentField,
      showCvcForStoredCard,
      showCvc,
      kcpFieldVisibility.index,
      socialSecurityNumberFieldVisibility.index,
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
      kcpFieldVisibility: FieldVisibility.values[result[5]! as int],
      socialSecurityNumberFieldVisibility: FieldVisibility.values[result[6]! as int],
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
    required this.googlePayEnvironment,
    this.merchantAccount,
    required this.allowedCardNetworks,
    required this.allowedAuthMethods,
    this.totalPriceStatus,
    required this.allowPrepaidCards,
    required this.billingAddressRequired,
    required this.emailRequired,
    required this.shippingAddressRequired,
    required this.existingPaymentMethodRequired,
  });

  GooglePayEnvironment googlePayEnvironment;

  String? merchantAccount;

  List<String?> allowedCardNetworks;

  List<String?> allowedAuthMethods;

  TotalPriceStatus? totalPriceStatus;

  bool allowPrepaidCards;

  bool billingAddressRequired;

  bool emailRequired;

  bool shippingAddressRequired;

  bool existingPaymentMethodRequired;

  Object encode() {
    return <Object?>[
      googlePayEnvironment.index,
      merchantAccount,
      allowedCardNetworks,
      allowedAuthMethods,
      totalPriceStatus?.index,
      allowPrepaidCards,
      billingAddressRequired,
      emailRequired,
      shippingAddressRequired,
      existingPaymentMethodRequired,
    ];
  }

  static GooglePayConfigurationDTO decode(Object result) {
    result as List<Object?>;
    return GooglePayConfigurationDTO(
      googlePayEnvironment: GooglePayEnvironment.values[result[0]! as int],
      merchantAccount: result[1] as String?,
      allowedCardNetworks: (result[2] as List<Object?>?)!.cast<String?>(),
      allowedAuthMethods: (result[3] as List<Object?>?)!.cast<String?>(),
      totalPriceStatus: result[4] != null
          ? TotalPriceStatus.values[result[4]! as int]
          : null,
      allowPrepaidCards: result[5]! as bool,
      billingAddressRequired: result[6]! as bool,
      emailRequired: result[7]! as bool,
      shippingAddressRequired: result[8]! as bool,
      existingPaymentMethodRequired: result[9]! as bool,
    );
  }
}

class CashAppPayConfigurationDTO {
  CashAppPayConfigurationDTO({
    required this.cashAppPayEnvironment,
    required this.returnUrl,
  });

  CashAppPayEnvironment cashAppPayEnvironment;

  String returnUrl;

  Object encode() {
    return <Object?>[
      cashAppPayEnvironment.index,
      returnUrl,
    ];
  }

  static CashAppPayConfigurationDTO decode(Object result) {
    result as List<Object?>;
    return CashAppPayConfigurationDTO(
      cashAppPayEnvironment: CashAppPayEnvironment.values[result[0]! as int],
      returnUrl: result[1]! as String,
    );
  }
}

class PaymentResultDTO {
  PaymentResultDTO({
    required this.type,
    this.reason,
    this.result,
  });

  PaymentResultEnum type;

  String? reason;

  PaymentResultModelDTO? result;

  Object encode() {
    return <Object?>[
      type.index,
      reason,
      result?.encode(),
    ];
  }

  static PaymentResultDTO decode(Object result) {
    result as List<Object?>;
    return PaymentResultDTO(
      type: PaymentResultEnum.values[result[0]! as int],
      reason: result[1] as String?,
      result: result[2] != null
          ? PaymentResultModelDTO.decode(result[2]! as List<Object?>)
          : null,
    );
  }
}

class PaymentResultModelDTO {
  PaymentResultModelDTO({
    this.sessionId,
    this.sessionData,
    this.resultCode,
    this.order,
  });

  String? sessionId;

  String? sessionData;

  String? resultCode;

  OrderResponseDTO? order;

  Object encode() {
    return <Object?>[
      sessionId,
      sessionData,
      resultCode,
      order?.encode(),
    ];
  }

  static PaymentResultModelDTO decode(Object result) {
    result as List<Object?>;
    return PaymentResultModelDTO(
      sessionId: result[0] as String?,
      sessionData: result[1] as String?,
      resultCode: result[2] as String?,
      order: result[3] != null
          ? OrderResponseDTO.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class OrderResponseDTO {
  OrderResponseDTO({
    required this.pspReference,
    required this.orderData,
    this.amount,
    this.remainingAmount,
  });

  String pspReference;

  String orderData;

  AmountDTO? amount;

  AmountDTO? remainingAmount;

  Object encode() {
    return <Object?>[
      pspReference,
      orderData,
      amount?.encode(),
      remainingAmount?.encode(),
    ];
  }

  static OrderResponseDTO decode(Object result) {
    result as List<Object?>;
    return OrderResponseDTO(
      pspReference: result[0]! as String,
      orderData: result[1]! as String,
      amount: result[2] != null
          ? AmountDTO.decode(result[2]! as List<Object?>)
          : null,
      remainingAmount: result[3] != null
          ? AmountDTO.decode(result[3]! as List<Object?>)
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

  PaymentResultDTO? paymentResult;

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
          ? PaymentResultDTO.decode(result[2]! as List<Object?>)
          : null,
    );
  }
}

class DropInResultDTO {
  DropInResultDTO({
    required this.dropInResultType,
    this.result,
    this.actionResponse,
    this.error,
  });

  DropInResultType dropInResultType;

  String? result;

  Map<String?, Object?>? actionResponse;

  DropInErrorDTO? error;

  Object encode() {
    return <Object?>[
      dropInResultType.index,
      result,
      actionResponse,
      error?.encode(),
    ];
  }

  static DropInResultDTO decode(Object result) {
    result as List<Object?>;
    return DropInResultDTO(
      dropInResultType: DropInResultType.values[result[0]! as int],
      result: result[1] as String?,
      actionResponse: (result[2] as Map<Object?, Object?>?)?.cast<String?, Object?>(),
      error: result[3] != null
          ? DropInErrorDTO.decode(result[3]! as List<Object?>)
          : null,
    );
  }
}

class DropInErrorDTO {
  DropInErrorDTO({
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

  static DropInErrorDTO decode(Object result) {
    result as List<Object?>;
    return DropInErrorDTO(
      errorMessage: result[0] as String?,
      reason: result[1] as String?,
      dismissDropIn: result[2] as bool?,
    );
  }
}

class DeletedStoredPaymentMethodResultDTO {
  DeletedStoredPaymentMethodResultDTO({
    required this.storedPaymentMethodId,
    required this.isSuccessfullyRemoved,
  });

  String storedPaymentMethodId;

  bool isSuccessfullyRemoved;

  Object encode() {
    return <Object?>[
      storedPaymentMethodId,
      isSuccessfullyRemoved,
    ];
  }

  static DeletedStoredPaymentMethodResultDTO decode(Object result) {
    result as List<Object?>;
    return DeletedStoredPaymentMethodResultDTO(
      storedPaymentMethodId: result[0]! as String,
      isSuccessfullyRemoved: result[1]! as bool,
    );
  }
}

class _CheckoutPlatformInterfaceCodec extends StandardMessageCodec {
  const _CheckoutPlatformInterfaceCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is AmountDTO) {
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
    } else if (value is CashAppPayConfigurationDTO) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is DeletedStoredPaymentMethodResultDTO) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is DropInConfigurationDTO) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is DropInErrorDTO) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is DropInResultDTO) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is GooglePayConfigurationDTO) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else if (value is SessionDTO) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128: 
        return AmountDTO.decode(readValue(buffer)!);
      case 129: 
        return AnalyticsOptionsDTO.decode(readValue(buffer)!);
      case 130: 
        return ApplePayConfigurationDTO.decode(readValue(buffer)!);
      case 131: 
        return CardsConfigurationDTO.decode(readValue(buffer)!);
      case 132: 
        return CashAppPayConfigurationDTO.decode(readValue(buffer)!);
      case 133: 
        return DeletedStoredPaymentMethodResultDTO.decode(readValue(buffer)!);
      case 134: 
        return DropInConfigurationDTO.decode(readValue(buffer)!);
      case 135: 
        return DropInErrorDTO.decode(readValue(buffer)!);
      case 136: 
        return DropInResultDTO.decode(readValue(buffer)!);
      case 137: 
        return GooglePayConfigurationDTO.decode(readValue(buffer)!);
      case 138: 
        return SessionDTO.decode(readValue(buffer)!);
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

  Future<void> startDropInSessionPayment(DropInConfigurationDTO arg_dropInConfigurationDTO, SessionDTO arg_session) async {
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

  Future<void> onPaymentsResult(DropInResultDTO arg_paymentsResult) async {
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

  Future<void> onPaymentsDetailsResult(DropInResultDTO arg_paymentsDetailsResult) async {
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

  Future<void> onDeleteStoredPaymentMethodResult(DeletedStoredPaymentMethodResultDTO arg_deleteStoredPaymentMethodResultDTO) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.onDeleteStoredPaymentMethodResult', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_deleteStoredPaymentMethodResultDTO]) as List<Object?>?;
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
    if (value is AmountDTO) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is OrderResponseDTO) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is PaymentResultDTO) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is PaymentResultModelDTO) {
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
        return AmountDTO.decode(readValue(buffer)!);
      case 129: 
        return OrderResponseDTO.decode(readValue(buffer)!);
      case 130: 
        return PaymentResultDTO.decode(readValue(buffer)!);
      case 131: 
        return PaymentResultModelDTO.decode(readValue(buffer)!);
      case 132: 
        return PlatformCommunicationModel.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class CheckoutFlutterApi {
  static const MessageCodec<Object?> codec = _CheckoutFlutterApiCodec();

  void onDropInSessionPlatformCommunication(PlatformCommunicationModel platformCommunicationModel);

  void onDropInAdvancedFlowPlatformCommunication(PlatformCommunicationModel platformCommunicationModel);

  static void setup(CheckoutFlutterApi? api, {BinaryMessenger? binaryMessenger}) {
    {
      final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
          'dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionPlatformCommunication', codec,
          binaryMessenger: binaryMessenger);
      if (api == null) {
        channel.setMessageHandler(null);
      } else {
        channel.setMessageHandler((Object? message) async {
          assert(message != null,
          'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionPlatformCommunication was null.');
          final List<Object?> args = (message as List<Object?>?)!;
          final PlatformCommunicationModel? arg_platformCommunicationModel = (args[0] as PlatformCommunicationModel?);
          assert(arg_platformCommunicationModel != null,
              'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionPlatformCommunication was null, expected non-null PlatformCommunicationModel.');
          api.onDropInSessionPlatformCommunication(arg_platformCommunicationModel!);
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
