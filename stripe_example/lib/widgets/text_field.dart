import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final EdgeInsets? padding;

  const PrimaryTextField({
    Key? key,
    this.hintText,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.inputFormatters,
    this.onChanged,
    this.validator,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _TextFormField(
      hintText: hintText,
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      suffixIcon: suffixIcon,
      inputFormatters: inputFormatters,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      padding: padding,
    );
  }
}

class _TextFormField extends FormField<String> {
  final String? hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final VoidCallback? onTap;
  final EdgeInsets? padding;
  final List<TextInputFormatter>? inputFormatters;

  _TextFormField({
    Key? key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.obscureText = false,
    this.suffixIcon,
    this.onTap,
    this.padding,
    AutovalidateMode autovalidateMode = AutovalidateMode.onUserInteraction,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
  }) : super(
          key: key,
          initialValue: controller.text,
          validator: validator,
          autovalidateMode: autovalidateMode,
          builder: (FormFieldState<String> field) {
            void onChangedHandler(String value) {
              field.didChange(value);
              if (onChanged != null) {
                onChanged(value);
              }
            }

            BoxBorder setBorder() {
              Color borderColor = field.isValid
                  ? Colors.grey.shade400
                  : field.hasError
                      ? Colors.red
                      : Colors.grey.shade400;
              return Border.all(width: 0.3, color: borderColor);
            }

            return UnmanagedRestorationScope(
              bucket: field.bucket,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: setBorder(),
                    ),
                    child: TextField(
                      enableInteractiveSelection: false,
                      controller: controller,
                      style: const TextStyle(
                        fontSize: 16,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                      ),
                      onChanged: onChangedHandler,
                      keyboardType: keyboardType,
                      obscureText: obscureText,
                      onTap: onTap,
                      inputFormatters: inputFormatters,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: const TextStyle(
                          fontSize: 15,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                        filled: true,
                        fillColor: Colors.grey.withOpacity(0.04),
                        contentPadding: padding ??
                            const EdgeInsets.symmetric(horizontal: 10),
                        suffixIcon: suffixIcon,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  if (field.hasError)
                    Padding(
                      padding: const EdgeInsets.only(top: 4, left: 4),
                      child: Text(
                        field.errorText ?? '',
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 11,
                          letterSpacing: 0.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
}
