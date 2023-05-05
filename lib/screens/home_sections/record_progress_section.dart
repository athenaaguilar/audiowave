import 'package:audio_wave/app_constants.dart';
import 'package:audio_wave/int_extensions.dart';
import 'package:audio_wave/widgets/app_icon.dart';
import 'package:flutter/material.dart';

class RecordProgressSection extends StatelessWidget {
  const RecordProgressSection({
    required this.secondsElapsed,
    super.key,
  });

  final int secondsElapsed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const AppIcon(iconColor: appSecondaryColor, height: 48),
        const Text(
          'Recording...',
          style: TextStyle(color: appSecondaryColor, fontSize: 20),
        ),
        const SizedBox(height: 35),
        Text(
          secondsElapsed.toMinuteSeconds,
          style: const TextStyle(
            color: appSecondaryColor,
            fontSize: 35,
            letterSpacing: 3,
          ),
        ),
      ],
    );
  }
}
