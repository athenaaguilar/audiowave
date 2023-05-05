import 'dart:convert';
import 'dart:io';

import 'package:audio_wave/app_constants.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class RecordSuccessSection extends StatefulWidget {
  const RecordSuccessSection({
    required this.data,
    required this.file,
    required this.playRecordedAudio,
    super.key,
  });

  final String data;
  final File file;
  final VoidCallback playRecordedAudio;

  @override
  State<RecordSuccessSection> createState() => _RecordSuccessSectionState();
}

class _RecordSuccessSectionState extends State<RecordSuccessSection> {
  late PlayerController playerController;
  List<double> waveformData = [];

  @override
  void initState() {
    getWaveformData();
    playerController = PlayerController();
    super.initState();
  }

  getWaveformData() async {
    final Uint8List bytes = base64.decode(widget.data);
    waveformData = bytes.map((e) => e.toDouble()).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: widget.playRecordedAudio,
          child: ColoredBox(
            color: appSecondaryColor.withOpacity(0.1),
            child: AudioFileWaveforms(
              padding: const EdgeInsets.symmetric(horizontal: 95),
              waveformData: waveformData,
              playerController: playerController,
              size: const Size(double.infinity, 200),
              enableSeekGesture: false,
              waveformType: WaveformType.fitWidth,
              playerWaveStyle: PlayerWaveStyle(
                scaleFactor: 0.3,
                fixedWaveColor: appSecondaryColor.withOpacity(0.5),
                waveCap: StrokeCap.round,
                spacing: 15,
                waveThickness: 7,
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          icon: const Icon(Icons.volume_up_sharp),
          label: const Text('Listen'),
          onPressed: widget.playRecordedAudio,
        ),
      ],
    );
  }
}
