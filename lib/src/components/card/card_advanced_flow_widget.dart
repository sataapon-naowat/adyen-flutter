import 'dart:async';

import 'package:adyen_checkout/adyen_checkout.dart';
import 'package:adyen_checkout/src/components/adyen_component_api.dart';
import 'package:adyen_checkout/src/components/component_result_api.dart';
import 'package:adyen_checkout/src/generated/platform_api.g.dart';
import 'package:adyen_checkout/src/utils/dto_mapper.dart';
import 'package:adyen_checkout/src/utils/payment_flow_outcome_handler.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

class CardAdvancedFlowWidget extends StatefulWidget {
  const CardAdvancedFlowWidget({
    required this.cardComponentConfiguration,
    required this.paymentMethods,
    required this.onPayments,
    required this.onPaymentsDetails,
    required this.onPaymentResult,
    required this.initialHeight,
    super.key,
  });

  final CardComponentConfiguration cardComponentConfiguration;
  final String paymentMethods;
  final Future<PaymentFlowOutcome> Function(String) onPayments;
  final Future<PaymentFlowOutcome> Function(String) onPaymentsDetails;
  final Future<void> Function(PaymentResult) onPaymentResult;
  final double initialHeight;

  @override
  State<CardAdvancedFlowWidget> createState() => _CardAdvancedFlowWidgetState();
}

class _CardAdvancedFlowWidgetState extends State<CardAdvancedFlowWidget> {
  final MessageCodec<Object?> _codec = ComponentFlutterApi.codec;
  final AdyenComponentApi _adyenComponentApi = AdyenComponentApi();
  final ComponentResultApi _resultApi = ComponentResultApi();
  final PaymentFlowOutcomeHandler _paymentFlowOutcomeHandler =
      PaymentFlowOutcomeHandler();
  late StreamController<double> _resizeStream;
  late Widget _cardView;

  @override
  void initState() {
    super.initState();

    _resizeStream = StreamController<double>.broadcast();
    _resultApi.componentCommunicationStream =
        StreamController<ComponentCommunicationModel>.broadcast();
    ComponentFlutterApi.setup(_resultApi);
    _cardView = buildCardView();
    _resultApi.componentCommunicationStream.stream
        .asBroadcastStream()
        .listen((event) async {
      switch (event.type) {
        case ComponentCommunicationType.onSubmit:
          _onSubmit(event);
        case ComponentCommunicationType.additionalDetails:
          _onAdditionalDetails(event);
        case ComponentCommunicationType.error:
          _onError(event);
        case ComponentCommunicationType.resize:
          _onResize(event);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        initialData: widget.initialHeight,
        stream: _resizeStream.stream.distinct(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          double platformHeight = snapshot.data;
          print("PlatformHeight: $platformHeight");
          return SizedBox(
            height: platformHeight,
            child: _cardView,
          );
        });
  }

  @override
  void dispose() {
    _resultApi.componentCommunicationStream.close();
    _resizeStream.close();
    super.dispose();
  }

  Future<void> _onSubmit(ComponentCommunicationModel event) async {
    final PaymentFlowOutcome paymentFlowOutcome =
        await widget.onPayments(event.data as String);
    _handlePaymentFlowOutcome(paymentFlowOutcome);
  }

  Future<void> _onAdditionalDetails(ComponentCommunicationModel event) async {
    final PaymentFlowOutcome paymentFlowOutcome =
        await widget.onPaymentsDetails(event.data as String);
    _handlePaymentFlowOutcome(paymentFlowOutcome);
  }

  void _onError(ComponentCommunicationModel event) =>
      widget.onPaymentResult(PaymentError(reason: event.data as String?));

  void _onResize(ComponentCommunicationModel event) =>
      _resizeStream.add(event.data as double);

  void _handlePaymentFlowOutcome(PaymentFlowOutcome paymentFlowOutcome) {
    final PaymentFlowOutcomeDTO paymentFlowOutcomeDTO =
        _paymentFlowOutcomeHandler.mapToPaymentOutcomeDTO(paymentFlowOutcome);
    switch (paymentFlowOutcomeDTO.paymentFlowResultType) {
      case PaymentFlowResultType.finished:
        widget.onPaymentResult(PaymentAdvancedFlowFinished(
            resultCode: paymentFlowOutcomeDTO.result ?? ""));
        setState(() {});
      case PaymentFlowResultType.action:
        _adyenComponentApi.onAction(paymentFlowOutcomeDTO.actionResponse);
      case PaymentFlowResultType.error:
        widget.onPaymentResult(
            PaymentError(reason: paymentFlowOutcomeDTO.error?.reason));
    }
  }

  Widget buildCardView() {
    const String viewType = 'cardComponent';
    final Map<String, dynamic> creationParams = <String, dynamic>{
      "paymentMethods": widget.paymentMethods,
      "cardComponentConfiguration": widget.cardComponentConfiguration.toDTO(),
    };

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return buildAndroidCardView(viewType, creationParams);
      case TargetPlatform.iOS:
        return buildIosCardView(viewType, creationParams);
      default:
        throw UnsupportedError('Unsupported platform view');
    }
  }

  Widget buildAndroidCardView(
      String viewType, Map<String, dynamic> creationParams) {
    SurfaceAndroidViewController surfaceAndroidViewController;

    return PlatformViewLink(
      viewType: viewType,
      surfaceFactory: (context, controller) {
        return AndroidViewSurface(
          controller: controller as AndroidViewController,
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
          hitTestBehavior: PlatformViewHitTestBehavior.opaque,
        );
      },
      onCreatePlatformView: (params) {
        surfaceAndroidViewController =
            PlatformViewsService.initSurfaceAndroidView(
          id: params.id,
          viewType: viewType,
          layoutDirection: TextDirection.ltr,
          creationParams: creationParams,
          creationParamsCodec: _codec,
          onFocus: () {
            params.onFocusChanged(true);
          },
        )
              ..addOnPlatformViewCreatedListener(params.onPlatformViewCreated)
              ..create();

        return surfaceAndroidViewController;
      },
    );
  }

  Widget buildIosCardView(
      String viewType, Map<String, dynamic> creationParams) {
    return UiKitView(
      viewType: viewType,
      layoutDirection: TextDirection.ltr,
      creationParams: creationParams,
      hitTestBehavior: PlatformViewHitTestBehavior.opaque,
      creationParamsCodec: _codec,
    );
  }
}
