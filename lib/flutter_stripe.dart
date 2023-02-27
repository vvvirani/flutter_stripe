library flutter_stripe;

import 'package:flutter_stripe/src/client/exceptions.dart';
import 'package:flutter_stripe/src/client/stripe_client.dart';
import 'package:flutter_stripe/src/resources/payment_intent_resource.dart';
import 'package:flutter_stripe/src/resources/customer_resource.dart';
import 'package:flutter_stripe/src/resources/payment_method_resource.dart';
import 'package:flutter_stripe/src/stripe_payment_interface.dart';

export 'src/models/customer/customer.dart';
export 'src/models/customer/customer_create_params.dart';

export 'src/models/payment_intent/payment_intent.dart';
export 'src/models/payment_intent/payment_intent_create_params.dart';

export 'src/models/payment_method/payment_method.dart';
export 'src/models/payment_method/payment_method_create_params.dart';
export 'src/models/payment_method/card_brand.dart' hide WalletBrand;

export 'src/resources/customer_resource.dart' hide CustomerInterface;
export 'src/resources/payment_intent_resource.dart' hide PaymentIntentInterface;
export 'src/resources/payment_method_resource.dart' hide PaymentMethodInterface;

export 'src/models/stripe_error.dart';

export 'src/client/exceptions.dart';

export 'src/utils/card_utils.dart';
export 'src/utils/input_formatters.dart';

class Stripe implements StripePaymentInterface {
  Stripe._();

  static final Stripe instance = Stripe._();

  StripeClient? _client;

  @override
  void initialize({required String secretKey, String? stripeAccountId}) {
    instance._client = StripeClient(
      secretKey: secretKey,
      stripeAccountId: stripeAccountId,
    );
  }

  @override
  CustomerResource get customers {
    StripeClient? client = instance._client;
    if (client != null) {
      return CustomerResource(client);
    } else {
      throw StripeException('Stripe is not initialized');
    }
  }

  @override
  PaymentIntentResource get paymentIntents {
    StripeClient? client = instance._client;
    if (client != null) {
      return PaymentIntentResource(client);
    } else {
      throw StripeException('Stripe is not initialized');
    }
  }

  @override
  PaymentMethodResource get paymentMethods {
    StripeClient? client = instance._client;
    if (client != null) {
      return PaymentMethodResource(_client!);
    } else {
      throw StripeException('Stripe is not initialized');
    }
  }
}
