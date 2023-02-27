import 'package:flutter_stripe/src/models/payment_method/payment_method.dart';

class CustomerCreateParams {
  final String name;
  final String email;
  final String? phone;
  final Address? address;

  const CustomerCreateParams({
    required this.name,
    required this.email,
    this.phone,
    this.address,
  });

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address?.toMap(),
    };
  }
}
