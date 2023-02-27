import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_svg/svg.dart';
import 'package:stripe_example/widgets/text_field.dart';

class CardDetailsForm extends StatelessWidget {
  final CardBrand? brand;
  final TextEditingController number;
  final TextEditingController expiryDate;
  final TextEditingController cvc;

  const CardDetailsForm({
    super.key,
    this.brand,
    required this.number,
    required this.expiryDate,
    required this.cvc,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryTextField(
          controller: number,
          hintText: 'Card Number',
          keyboardType: TextInputType.number,
          validator: CardUtils.validateCardNum,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 14,
            bottom: 12,
          ),
          suffixIcon: brand != null && number.text.isNotEmpty
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      brand?.logo ?? '',
                      package: 'flutter_stripe',
                    ),
                    const SizedBox(width: 15),
                  ],
                )
              : _buildCardBrands(),
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(16),
            CardNumberInputFormatter()
          ],
        ),
        const SizedBox(height: 15),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: PrimaryTextField(
                controller: expiryDate,
                hintText: 'MM / YY',
                keyboardType: TextInputType.number,
                validator: CardUtils.validateDate,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                  CardMonthInputFormatter()
                ],
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: PrimaryTextField(
                controller: cvc,
                hintText: 'CVC',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
                validator: CardUtils.validateCVC,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCardBrands() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          CardBrand.visa.logo,
          package: 'flutter_stripe',
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(
          CardBrand.mastercard.logo,
          package: 'flutter_stripe',
        ),
        const SizedBox(width: 8),
        SvgPicture.asset(
          CardBrand.amex.logo,
          package: 'flutter_stripe',
        ),
        const SizedBox(width: 15),
      ],
    );
  }
}
