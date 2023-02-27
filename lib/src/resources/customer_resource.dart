import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_stripe/src/client/stripe_client.dart';

abstract class CustomerInterface {
  Future<Customer> create(CustomerCreateParams params);

  Future<Customer> get(String customerId);
}

class CustomerResource implements CustomerInterface {
  final StripeClient _client;

  CustomerResource(this._client);

  @override
  Future<Customer> create(CustomerCreateParams params) async {
    Response<dynamic> response = await _client.request(
      path: '/customers',
      method: MethodType.post,
      data: params.asMap(),
    );
    return Customer.fromMap(response.data);
  }

  @override
  Future<Customer> get(String customerId) async {
    Response<dynamic> response = await _client.request(
      path: '/customers/$customerId',
      method: MethodType.post,
    );
    return Customer.fromMap(response.data);
  }
}
