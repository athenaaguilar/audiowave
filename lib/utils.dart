import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

void showCustomToast(String message, BuildContext context) {
  showToast(
    message,
    context: context,
    borderRadius: const BorderRadius.all(Radius.circular(20)),
    position: StyledToastPosition.bottom,
    animation: StyledToastAnimation.fade,
    reverseAnimation: StyledToastAnimation.fade,
    textAlign: TextAlign.left,
    fullWidth: true,
    toastHorizontalMargin: 25,
  );
}
