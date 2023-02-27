import 'package:flutter/material.dart';

class PrimaryMaterialButton extends StatelessWidget {
  final String label;
  final double? height;
  final double? width;
  final Color? backgroundColor;
  final VoidCallback? onPressed;

  const PrimaryMaterialButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.backgroundColor,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    bool enabled = onPressed != null;

    return SizedBox(
      width: width,
      child: MaterialButton(
        textColor: Colors.white,
        color: backgroundColor ?? Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: height,
        elevation: 0,
        disabledElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        focusElevation: 0,
        splashColor: Colors.white.withOpacity(0.1),
        highlightColor: Colors.white.withOpacity(0.1),
        disabledColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: enabled
            ? () {
                FocusScope.of(context).requestFocus(FocusNode());
                onPressed?.call();
              }
            : null,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
}
