import 'package:flutter_stripe/src/models/payment_method/payment_method.dart';

class Customer {
  final String? id;
  final Address? address;
  final DateTime? created;
  final String? defaultSource;
  final String? email;
  final bool liveMode;
  final String? name;
  final String? phone;

  Customer({
    this.id,
    this.address,
    this.created,
    this.defaultSource,
    this.email,
    this.liveMode = false,
    this.name,
    this.phone,
  });

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(
      id: map['id'],
      address: map['address'],
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] * 1000),
      defaultSource: map['default_source'],
      email: map['email'],
      liveMode: map['livemode'],
      name: map['name'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'address': address,
      'created': created,
      'default_source': defaultSource,
      'email': email,
      'livemode': liveMode,
      'name': name,
      'phone': phone,
    };
  }
}
