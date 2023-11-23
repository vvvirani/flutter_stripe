import 'package:dio/dio.dart';
import 'package:flutter_stripe/src/client/header_builder.dart';
import 'package:flutter_stripe/src/models/stripe_error.dart';

import 'exceptions.dart';

export 'package:dio/dio.dart' show Response;

const String _kStripeBaseUrl = 'https://api.stripe.com/v1';

enum MethodType { post, get }

class StripeClient {
  final Dio _dio;
  final String secretKey;
  final String? stripeAccountId;

  StripeClient({required this.secretKey, this.stripeAccountId})
      : _dio = Dio(BaseOptions(baseUrl: _kStripeBaseUrl))
          ..interceptors.addAll(
            [
              _LogInterceptor(),
              _AuthorizationInterceptor(
                secretKey: secretKey,
                stripeAccountId: stripeAccountId,
              )
            ],
          );

  Future<Response<dynamic>> request({
    required String path,
    required MethodType method,
    dynamic data,
  }) async {
    try {
      return await _dio.request(
        path,
        data: data,
        options: Options(method: method.name.toUpperCase()),
      );
    } on DioException catch (e) {
      Response<dynamic>? response = e.response;
      if (response != null) {
        throw StripeException(
          e.error.toString(),
          error: StripeError.fromMap(response.data['error']),
        );
      } else {
        throw StripeException(e.error.toString());
      }
    } catch (e) {
      throw StripeException(e.toString());
    }
  }
}

class _LogInterceptor extends LogInterceptor {
  _LogInterceptor()
      : super(
          request: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
        );
}

class _AuthorizationInterceptor extends Interceptor {
  final String secretKey;
  final String? stripeAccountId;

  _AuthorizationInterceptor({required this.secretKey, this.stripeAccountId});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);

    options.headers = HeaderBuilder.builder()
        .setContentType('application/x-www-form-urlencoded')
        .setBearerToken(secretKey)
        .setExtra('Stripe-Account', stripeAccountId)
        .build();
  }
}
