import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    required this.iconColor,
    this.height = 28,
    super.key,
  });

  final Color iconColor;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/app_icon.svg',
      height: height,
      color: iconColor,
    );
  }
}
