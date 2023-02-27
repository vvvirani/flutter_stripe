import 'package:collection/collection.dart';

class PaymentIntent {
  final String id;
  final num amount;
  final DateTime? created;
  final String currency;
  final PaymentIntentsStatus status;
  final String clientSecret;
  final bool liveMode;
  final CaptureMethod? captureMethod;
  final ConfirmationMethod? confirmationMethod;
  final String? customerId;
  final String? description;
  final String? receiptEmail;
  final NextAction? nextAction;
  final String? paymentMethodId;
  final SetupFutureUsage? setupFutureUsage;

  const PaymentIntent({
    required this.id,
    required this.amount,
    this.created,
    required this.currency,
    this.status = PaymentIntentsStatus.unknown,
    required this.clientSecret,
    this.liveMode = false,
    this.captureMethod,
    this.confirmationMethod,
    this.customerId,
    this.description,
    this.receiptEmail,
    this.nextAction,
    this.paymentMethodId,
    this.setupFutureUsage,
  });

  factory PaymentIntent.fromMap(Map<String, dynamic> map) {
    return PaymentIntent(
      id: map['id'],
      amount: map['amount'],
      captureMethod: CaptureMethod.values
          .firstWhereOrNull((e) => e.name == map['capture_method']),
      clientSecret: map['client_secret'],
      confirmationMethod: ConfirmationMethod.values
          .firstWhereOrNull((e) => e.name == map['confirmation_method']),
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] * 1000),
      currency: map['currency'],
      customerId: map['customer'],
      description: map['description'],
      liveMode: map['livemode'],
      nextAction: map['next_action'] != null
          ? NextAction.fromMap(map['next_action'])
          : null,
      paymentMethodId: map['payment_method'],
      receiptEmail: map['receipt_email'],
      setupFutureUsage: SetupFutureUsage.values
          .firstWhereOrNull((e) => e.value == map['setup_future_usage']),
      status: PaymentIntentsStatus.values.firstWhere(
        (e) => e.value == map['status'],
        orElse: () => PaymentIntentsStatus.unknown,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'capture_method': captureMethod?.name,
      'client_secret': clientSecret,
      'confirmation_method': confirmationMethod?.name,
      'created': created,
      'currency': currency,
      'customer': customerId,
      'livemode': liveMode,
      'description': description,
      'next_action': nextAction?.toMap(),
      'payment_method': paymentMethodId,
      'receipt_email': receiptEmail,
      'setup_future_usage': setupFutureUsage,
      'status': status.value,
    };
  }
}

class NextAction {
  final RedirectToUrl? redirectToUrl;
  final NextActionType? type;

  const NextAction({this.redirectToUrl, this.type});

  factory NextAction.fromMap(Map<String, dynamic> map) {
    return NextAction(
      redirectToUrl: map['redirect_to_url'] != null
          ? RedirectToUrl.fromMap(map['redirect_to_url'])
          : null,
      type:
          NextActionType.values.firstWhereOrNull((e) => e.value == map['type']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'redirect_to_url': redirectToUrl?.toMap(),
      'type': type,
    };
  }
}

class RedirectToUrl {
  final String? returnUrl;
  final String? url;

  const RedirectToUrl({this.returnUrl, this.url});

  factory RedirectToUrl.fromMap(Map<String, dynamic> map) {
    return RedirectToUrl(returnUrl: map['return_url'], url: map['url']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'return_url': returnUrl, 'url': url};
  }
}

enum CaptureMethod { manual, automatic }

enum ConfirmationMethod { manual, automatic }

enum SetupFutureUsage {
  offSession('off_session'),
  onSession('on_session');

  final String value;
  const SetupFutureUsage(this.value);
}

enum PaymentIntentsStatus {
  succeeded('succeeded'),
  requiresPaymentMethod('requires_payment_method'),
  requiresConfirmation('requires_confirmation'),
  canceled('canceled'),
  processing('processing'),
  requiresAction('requires_action'),
  requiresCapture('requires_capture'),
  unknown('unknown');

  final String value;

  const PaymentIntentsStatus(this.value);
}

enum NextActionType {
  urlRedirect('redirect_to_url');

  final String value;

  const NextActionType(this.value);
}
