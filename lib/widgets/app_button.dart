import 'package:audio_wave/app_constants.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onPressed,
    required this.buttonText,
    this.disabled = true,
    super.key,
  });

  final VoidCallback onPressed;
  final String buttonText;
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: TextButton(
        onPressed: disabled ? null : onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: disabled ? disabledColor : appSecondaryColor,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
