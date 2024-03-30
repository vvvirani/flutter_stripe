import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentMethodCreateParams {
  final PaymentMethodType type;
  final String number;
  final int expMonth;
  final int expYear;
  final String cvc;
  final BillingDetails? billingDetails;

  PaymentMethodCreateParams.card({
    required this.number,
    required this.expMonth,
    required this.expYear,
    required this.cvc,
    this.billingDetails,
  }) : type = PaymentMethodType.card;

  const PaymentMethodCreateParams({
    required this.type,
    required this.number,
    required this.expMonth,
    required this.expYear,
    required this.cvc,
    this.billingDetails,
  });

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'type': type.value,
      'card[number]': number,
      'card[exp_month]': expMonth,
      'card[exp_year]': expYear,
      'card[cvc]': cvc,
      if (billingDetails != null) ...billingDetails?.asMap() ?? {},
    };
  }
}
