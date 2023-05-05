import 'package:audio_wave/app_constants.dart';
import 'package:flutter/material.dart';

class RecordInitialSection extends StatelessWidget {
  const RecordInitialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          'Welcome!',
          style: TextStyle(
            color: appSecondaryColor,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        Text(
          'Record your audio now...',
          style: TextStyle(color: appSecondaryColor, fontSize: 20),
        ),
      ],
    );
  }
}
