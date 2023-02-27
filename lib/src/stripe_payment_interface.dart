import 'package:flutter_stripe/src/resources/customer_resource.dart';
import 'package:flutter_stripe/src/resources/payment_intent_resource.dart';
import 'package:flutter_stripe/src/resources/payment_method_resource.dart';

abstract class StripePaymentInterface {
  final CustomerResource customers;
  final PaymentIntentResource paymentIntents;
  final PaymentMethodResource paymentMethods;

  const StripePaymentInterface({
    required this.customers,
    required this.paymentIntents,
    required this.paymentMethods,
  });

  void initialize({required String secretKey, String? stripeAccountId});
}
