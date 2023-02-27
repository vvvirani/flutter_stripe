import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe/src/client/stripe_client.dart';

abstract class PaymentMethodInterface {
  Future<PaymentMethod> create(PaymentMethodCreateParams params);

  Future<List<PaymentMethod>> lists({
    String? customerId,
    PaymentMethodType type = PaymentMethodType.card,
    int limit = 20,
  });

  Future<PaymentMethod> attach(String methodId);

  Future<PaymentMethod> detach(String methodId);
}

class PaymentMethodResource implements PaymentMethodInterface {
  final StripeClient _client;

  PaymentMethodResource(this._client);

  @override
  Future<PaymentMethod> create(PaymentMethodCreateParams params) async {
    Response<dynamic> response = await _client.request(
      path: '/payment_methods',
      method: MethodType.post,
      data: params.asMap(),
    );
    return PaymentMethod.fromMap(response.data);
  }

  @override
  Future<List<PaymentMethod>> lists({
    String? customerId,
    PaymentMethodType type = PaymentMethodType.card,
    int limit = 20,
  }) async {
    String path = '/payment_methods';
    if (customerId != null) {
      path = '$path?customer=$customerId&type=${type.value}&limit=$limit';
    } else {
      path = '$path?type=${type.value}&limit=$limit';
    }
    Response<dynamic> response = await _client.request(
      path: path,
      method: MethodType.post,
    );
    return List<PaymentMethod>.from(
        response.data['data'].map((e) => PaymentMethod.fromMap(e)));
  }

  @override
  Future<PaymentMethod> attach(String methodId) async {
    Response<dynamic> response = await _client.request(
      path: '/payment_methods/$methodId/attach',
      method: MethodType.post,
    );
    return PaymentMethod.fromMap(response.data);
  }

  @override
  Future<PaymentMethod> detach(String methodId) async {
    Response<dynamic> response = await _client.request(
      path: '/payment_methods/$methodId/detach',
      method: MethodType.post,
    );
    return PaymentMethod.fromMap(response.data);
  }
}
