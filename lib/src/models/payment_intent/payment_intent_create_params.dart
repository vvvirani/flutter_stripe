import 'package:flutter_stripe/src/models/payment_intent/payment_intent.dart';

class PaymentIntentCreateParams {
  final num amount;
  final String currency;
  final String? description;
  final String? customerId;
  final bool confirm;
  final String paymentMethodId;
  final String? receiptEmail;
  final SetupFutureUsage? setupFutureUsage;
  final bool _useStripeSdk;
  final String _returnUrl;

  const PaymentIntentCreateParams({
    required this.amount,
    required this.currency,
    this.description,
    this.customerId,
    this.confirm = true,
    required this.paymentMethodId,
    this.receiptEmail,
    this.setupFutureUsage,
  })  : _returnUrl = 'https://3d_secure_authentication_complete.com',
        _useStripeSdk = false;

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'amount': amount,
      'currency': currency,
      if (description != null) 'description': description,
      'customer': customerId,
      'confirm': confirm,
      'payment_method': paymentMethodId,
      if (setupFutureUsage != null)
        'setup_future_usage': setupFutureUsage?.value,
      if (receiptEmail != null) 'receipt_email': receiptEmail,
      'return_url': _returnUrl,
      'use_stripe_sdk': _useStripeSdk,
    };
  }
}
