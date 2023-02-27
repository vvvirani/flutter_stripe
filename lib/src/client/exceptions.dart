import 'package:flutter_stripe/src/models/stripe_error.dart';

class StripeException implements Exception {
  final StripeError? error;
  final String message;

  StripeException(this.message, {this.error});

  @override
  String toString() {
    return 'StripeException(message: $message, error: ${error?.toMap()})';
  }
}
