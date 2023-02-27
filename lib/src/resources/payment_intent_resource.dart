import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe/src/client/stripe_client.dart';
import 'package:flutter_stripe/src/views/three_d_secure_authentication_view.dart';

abstract class PaymentIntentInterface {
  Future<PaymentIntent> create(PaymentIntentCreateParams params);

  Future<PaymentIntent> confirm(String intentId);

  Future<PaymentIntent> get(String intentId);

  Future<PaymentIntent> completeThreeDSecureAuthentication({
    required BuildContext context,
    required PaymentIntent intent,
  });
}

class PaymentIntentResource implements PaymentIntentInterface {
  final StripeClient _client;

  PaymentIntentResource(this._client);

  @override
  Future<PaymentIntent> create(PaymentIntentCreateParams params) async {
    Response<dynamic> response = await _client.request(
      path: '/payment_intents',
      method: MethodType.post,
      data: params.asMap(),
    );
    return PaymentIntent.fromMap(response.data);
  }

  @override
  Future<PaymentIntent> get(String intentId) async {
    Response<dynamic> response = await _client.request(
      path: '/payment_intents/$intentId',
      method: MethodType.post,
    );
    return PaymentIntent.fromMap(response.data);
  }

  @override
  Future<PaymentIntent> confirm(String intentId) async {
    Response<dynamic> response = await _client.request(
      path: '/payment_intents/$intentId/confirm',
      method: MethodType.post,
    );
    return PaymentIntent.fromMap(response.data);
  }

  @override
  Future<PaymentIntent> completeThreeDSecureAuthentication({
    required BuildContext context,
    required PaymentIntent intent,
  }) async {
    if (intent.nextAction != null) {
      if (intent.nextAction?.type == NextActionType.urlRedirect) {
        RedirectToUrl? redirectToUrl = intent.nextAction?.redirectToUrl;
        if (redirectToUrl != null) {
          bool completed = await ThreeDSecureAuthenticationView.buildView(
            context,
            redirectToUrl: redirectToUrl,
          );
          if (completed) {
            intent = await get(intent.id);
          }
        }
      }
      return intent;
    } else {
      throw StripeException('Next Action not found');
    }
  }
}
