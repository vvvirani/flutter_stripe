import 'package:collection/collection.dart';

class PaymentMethod {
  final String? id;
  final BillingDetails? billingDetails;
  final Card? card;
  final DateTime? created;
  final String? customerId;
  final bool liveMode;
  final PaymentMethodType? type;

  const PaymentMethod({
    this.id,
    this.billingDetails,
    this.card,
    this.created,
    this.customerId,
    this.liveMode = false,
    this.type,
  });

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'],
      billingDetails: map['billing_details'] != null
          ? BillingDetails.fromMap(map['billing_details'])
          : null,
      card: map['card'] != null ? Card.fromMap(map['card']) : map['card'],
      created: DateTime.fromMillisecondsSinceEpoch(map['created'] * 1000),
      customerId: map['customer'],
      liveMode: map['livemode'],
      type: PaymentMethodType.values
          .firstWhereOrNull((e) => e.name == map['type']),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'billing_details': billingDetails?.toMap(),
      'card': card?.toMap(),
      'created': created,
      'customer': customerId,
      'livemode': liveMode,
      'type': type,
    };
  }
}

class BillingDetails {
  final Address? address;
  final String? email;
  final String? name;
  final String? phone;

  const BillingDetails({this.address, this.email, this.name, this.phone});

  factory BillingDetails.fromMap(Map<String, dynamic> map) {
    return BillingDetails(
      address: map['address'] != null ? Address.fromMap(map['address']) : null,
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address?.toMap(),
      'email': email,
      'name': name,
      'phone': phone,
    };
  }

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'billing_details[email]': email,
      'billing_details[name]': name,
      'billing_details[phone]': phone,
      if (address != null) ...address?.asMap() ?? {},
    };
  }
}

class Address {
  final String city;
  final String country;
  final String line1;
  final String line2;
  final String postalCode;
  final String state;

  const Address({
    required this.city,
    required this.country,
    required this.line1,
    required this.line2,
    required this.postalCode,
    required this.state,
  });

  factory Address.fromMap(Map<String, dynamic> map) {
    return Address(
      city: map['city'],
      country: map['country'],
      line1: map['line1'],
      line2: map['line2'],
      postalCode: map['postal_code'],
      state: map['state'],
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'city': city,
      'country': country,
      'line1': line1,
      'line2': line2,
      'postal_code': postalCode,
      'state': state,
    };
  }

  Map<String, dynamic> asMap() {
    return <String, dynamic>{
      'billing_details[address][city]': city,
      'billing_details[address][country]': country,
      'billing_details[address][line1]': line1,
      'billing_details[address][line2]': line2,
      'billing_details[address][postal_code]': postalCode,
      'billing_details[address][state]': state,
    };
  }
}

class Card {
  final String? brand;
  final String? country;
  final int? expMonth;
  final int? expYear;
  final String? funding;
  final String? last4;
  final ThreeDSecureUsage? threeDSecureUsage;

  const Card({
    this.brand,
    this.country,
    this.expMonth,
    this.expYear,
    this.funding,
    this.last4,
    this.threeDSecureUsage,
  });

  factory Card.fromMap(Map<String, dynamic> map) {
    return Card(
      brand: map['brand'],
      country: map['country'],
      expMonth: map['exp_month'],
      expYear: map['exp_year'],
      funding: map['funding'],
      last4: map['last4'],
      threeDSecureUsage: map['three_d_secure_usage'] != null
          ? ThreeDSecureUsage.fromMap(map['three_d_secure_usage'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'brand': brand,
      'country': country,
      'exp_month': expMonth,
      'exp_year': expYear,
      'funding': funding,
      'last4': last4,
      'three_d_secure_usage': threeDSecureUsage?.toMap(),
    };
  }
}

class ThreeDSecureUsage {
  final bool supported;

  const ThreeDSecureUsage({this.supported = false});

  factory ThreeDSecureUsage.fromMap(Map<String, dynamic> map) {
    return ThreeDSecureUsage(supported: map['supported']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'supported': supported};
  }
}

enum PaymentMethodType {
  card('card'),
  usBankAccount('us_bank_account');

  final String value;
  const PaymentMethodType(this.value);
}
