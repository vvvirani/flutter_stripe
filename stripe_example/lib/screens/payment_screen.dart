import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:stripe_example/screens/card_details_form.dart';
import 'package:stripe_example/widgets/loader.dart';
import 'package:stripe_example/widgets/material_button.dart';
import 'package:stripe_example/widgets/text_field.dart';

const String _kSecretKey = '';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  //
  final Stripe _stripe = Stripe.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  CardBrand? _cardBrand;

  final TextEditingController _number = TextEditingController();
  final TextEditingController _expiryDate = TextEditingController();
  final TextEditingController _cvc = TextEditingController();

  final TextEditingController _amount = TextEditingController();

  void _getCardBrandFromNumber() {
    String? input = CardUtils.getCleanedNumber(_number.text);
    CardBrand brand = CardUtils.getCardBrandFromNumber(input);
    setState(() {
      _cardBrand = brand;
    });
  }

  Future<void> _onCheckout() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        Loader.show(context);

        List<String> expiryDate = _expiryDate.text.split('/');
        PaymentMethodCreateParams methodCreateParams =
            PaymentMethodCreateParams.card(
          number: _number.text.trim(),
          expMonth: int.parse(expiryDate.first),
          expYear: int.parse(expiryDate.last),
          cvc: _cvc.text.trim(),
        );

        PaymentMethod method =
            await _stripe.paymentMethods.create(methodCreateParams);

        if (method.id != null) {
          num amount = num.parse(_amount.text.trim()) * 100;
          PaymentIntentCreateParams intentCreateParams =
              PaymentIntentCreateParams(
            amount: amount.ceil(),
            currency: 'inr',
            paymentMethodId: method.id!,
          );

          PaymentIntent intent =
              await _stripe.paymentIntents.create(intentCreateParams);

          if (intent.status == PaymentIntentsStatus.succeeded) {
            _showSnackBar('Payment Succeeded');
          } else if (intent.status == PaymentIntentsStatus.requiresAction) {
            intent =
                await _stripe.paymentIntents.completeThreeDSecureAuthentication(
              context: context,
              intent: intent,
            );

            if (intent.status == PaymentIntentsStatus.succeeded) {
              _showSnackBar('Payment Succeeded');
            } else {
              _showSnackBar('Payment Failed');
            }
          } else {
            _showSnackBar('Payment Failed');
          }
        }
      } on StripeException catch (e) {
        _showSnackBar(e.error?.message ?? e.message);
      } finally {
        Loader.dismiss(context);
      }
    }
  }

  void _showSnackBar(String message) {
    SnackBar snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  void initState() {
    _stripe.initialize(secretKey: _kSecretKey);
    _number.addListener(_getCardBrandFromNumber);
    super.initState();
  }

  @override
  void dispose() {
    _number.removeListener(_getCardBrandFromNumber);
    _number.dispose();
    _expiryDate.dispose();
    _cvc.dispose();
    _amount.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Stripe Payment Demo'), elevation: 0),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter Card Details',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              CardDetailsForm(
                number: _number,
                expiryDate: _expiryDate,
                cvc: _cvc,
                brand: _cardBrand,
              ),
              const SizedBox(height: 40),
              Text(
                'Enter Amount (\u20B9)',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              PrimaryTextField(
                controller: _amount,
                hintText: 'Amount',
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return 'Amount is required';
                  }
                  return null;
                },
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 12,
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: SafeArea(
          child: PrimaryMaterialButton(
            label: 'Checkout',
            height: 48,
            onPressed: _onCheckout,
          ),
        ),
      ),
    );
  }
}
