// Autogenerated from Pigeon (v10.1.6), do not edit directly.
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

enum DropInResultEnum {
  cancelledByUser,
  error,
  finished,
}

enum PlatformCommunicationType {
  paymentComponent,
  additionalDetails,
  result,
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

class DropInConfiguration {
  DropInConfiguration({
    required this.environment,
    required this.clientKey,
    required this.amount,
    required this.countryCode,
    this.isAnalyticsEnabled,
    this.showPreselectedStoredPaymentMethod,
    this.skipListWhenSinglePaymentMethod,
    this.isRemovingStoredPaymentMethodsEnabled,
    this.additionalDataForDropInService,
  });

  Environment environment;

  String clientKey;

  Amount amount;

  String countryCode;

  bool? isAnalyticsEnabled;

  bool? showPreselectedStoredPaymentMethod;

  bool? skipListWhenSinglePaymentMethod;

  bool? isRemovingStoredPaymentMethodsEnabled;

  String? additionalDataForDropInService;

  Object encode() {
    return <Object?>[
      environment.index,
      clientKey,
      amount.encode(),
      countryCode,
      isAnalyticsEnabled,
      showPreselectedStoredPaymentMethod,
      skipListWhenSinglePaymentMethod,
      isRemovingStoredPaymentMethodsEnabled,
      additionalDataForDropInService,
    ];
  }

  static DropInConfiguration decode(Object result) {
    result as List<Object?>;
    return DropInConfiguration(
      environment: Environment.values[result[0]! as int],
      clientKey: result[1]! as String,
      amount: Amount.decode(result[2]! as List<Object?>),
      countryCode: result[3]! as String,
      isAnalyticsEnabled: result[4] as bool?,
      showPreselectedStoredPaymentMethod: result[5] as bool?,
      skipListWhenSinglePaymentMethod: result[6] as bool?,
      isRemovingStoredPaymentMethodsEnabled: result[7] as bool?,
      additionalDataForDropInService: result[8] as String?,
    );
  }
}

class SessionPaymentResultModel {
  SessionPaymentResultModel({
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

  static SessionPaymentResultModel decode(Object result) {
    result as List<Object?>;
    return SessionPaymentResultModel(
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

class DropInResult {
  DropInResult({
    required this.type,
    this.reason,
    this.result,
  });

  DropInResultEnum type;

  String? reason;

  SessionPaymentResultModel? result;

  Object encode() {
    return <Object?>[
      type.index,
      reason,
      result?.encode(),
    ];
  }

  static DropInResult decode(Object result) {
    result as List<Object?>;
    return DropInResult(
      type: DropInResultEnum.values[result[0]! as int],
      reason: result[1] as String?,
      result: result[2] != null
          ? SessionPaymentResultModel.decode(result[2]! as List<Object?>)
          : null,
    );
  }
}

class PlatformCommunicationModel {
  PlatformCommunicationModel({
    required this.type,
    this.data,
    this.dropInResult,
  });

  PlatformCommunicationType type;

  String? data;

  DropInResult? dropInResult;

  Object encode() {
    return <Object?>[
      type.index,
      data,
      dropInResult?.encode(),
    ];
  }

  static PlatformCommunicationModel decode(Object result) {
    result as List<Object?>;
    return PlatformCommunicationModel(
      type: PlatformCommunicationType.values[result[0]! as int],
      data: result[1] as String?,
      dropInResult: result[2] != null
          ? DropInResult.decode(result[2]! as List<Object?>)
          : null,
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
    } else if (value is DropInConfiguration) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is DropInResult) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is OrderResponseModel) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is PlatformCommunicationModel) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is Session) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is SessionPaymentResultModel) {
      buffer.putUint8(134);
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
        return DropInConfiguration.decode(readValue(buffer)!);
      case 130: 
        return DropInResult.decode(readValue(buffer)!);
      case 131: 
        return OrderResponseModel.decode(readValue(buffer)!);
      case 132: 
        return PlatformCommunicationModel.decode(readValue(buffer)!);
      case 133: 
        return Session.decode(readValue(buffer)!);
      case 134: 
        return SessionPaymentResultModel.decode(readValue(buffer)!);
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

  Future<void> startDropInSessionPayment(DropInConfiguration arg_dropInConfiguration, Session arg_session) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startDropInSessionPayment', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_dropInConfiguration, arg_session]) as List<Object?>?;
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

  Future<void> startDropInAdvancedFlowPayment(DropInConfiguration arg_dropInConfiguration, String arg_paymentMethodsResponse) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.adyen_checkout.CheckoutPlatformInterface.startDropInAdvancedFlowPayment', codec,
        binaryMessenger: _binaryMessenger);
    final List<Object?>? replyList =
        await channel.send(<Object?>[arg_dropInConfiguration, arg_paymentMethodsResponse]) as List<Object?>?;
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

  Future<void> onPaymentsResult(Map<String?, Object?> arg_paymentsResult) async {
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

  Future<void> onPaymentsDetailsResult(Map<String?, Object?> arg_paymentsDetailsResult) async {
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
    } else if (value is DropInResult) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is OrderResponseModel) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is PlatformCommunicationModel) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is SessionPaymentResultModel) {
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
        return DropInResult.decode(readValue(buffer)!);
      case 130: 
        return OrderResponseModel.decode(readValue(buffer)!);
      case 131: 
        return PlatformCommunicationModel.decode(readValue(buffer)!);
      case 132: 
        return SessionPaymentResultModel.decode(readValue(buffer)!);
      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

abstract class CheckoutFlutterApi {
  static const MessageCodec<Object?> codec = _CheckoutFlutterApiCodec();

  void onDropInSessionResult(DropInResult sessionDropInResult);

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
          final DropInResult? arg_sessionDropInResult = (args[0] as DropInResult?);
          assert(arg_sessionDropInResult != null,
              'Argument for dev.flutter.pigeon.adyen_checkout.CheckoutFlutterApi.onDropInSessionResult was null, expected non-null DropInResult.');
          api.onDropInSessionResult(arg_sessionDropInResult!);
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
