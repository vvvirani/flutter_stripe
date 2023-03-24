enum CardBrand {
  affirm('assets/cards/ic_affirm.svg'),
  amex('assets/cards/ic_amex.svg'),
  dinersClub('assets/cards/ic_diners_club.svg'),
  discover('assets/cards/ic_discover.svg'),
  jcb('assets/cards/ic_jcb.svg'),
  mastercard('assets/cards/ic_mastercard.svg'),
  visa('assets/cards/ic_visa.svg'),
  wise('assets/cards/ic_wise.svg'),
  unknown('');

  final String logo;

  const CardBrand(this.logo);
}

enum WalletBrand {
  payoneer('assets/cards/ic_payoneer.svg'),
  googlePay('assets/cards/ic_google_pay.svg'),
  applePay('assets/cards/ic_apple_pay.svg'),
  paypal('assets/cards/ic_paypal.svg'),
  unionPay('assets/cards/ic_union_pay.svg'),
  unknown('');

  final String logo;

  const WalletBrand(this.logo);
}
