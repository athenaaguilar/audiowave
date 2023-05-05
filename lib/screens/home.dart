// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_wave/app_constants.dart';
import 'package:audio_wave/screens/home_sections/record_initial_section.dart';
import 'package:audio_wave/screens/home_sections/record_progress_section.dart';
import 'package:audio_wave/screens/home_sections/record_success_section.dart';
import 'package:audio_wave/utils.dart';
import 'package:audio_wave/widgets/app_button.dart';
import 'package:audio_wave/widgets/app_icon.dart';
import 'package:audio_wave/widgets/record_button.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isRecording = false;
  bool hasRecording = false;
  int secondsElapsed = 0;

  late Timer timer;
  late String audioPath;
  late String audioPathTimeStamp;
  late String? audioData;

  final recorder = Record();
  final player = AssetsAudioPlayer();

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => secondsElapsed++),
    );
  }

  void stopTimer() {
    timer.cancel();
    setState(() => secondsElapsed = 0);
  }

  Future<void> startRecording() async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final int date = DateTime.now().microsecondsSinceEpoch;
    audioPath = '${directory.path}/${date}audiowave.wav';
    audioPathTimeStamp = date.toString();

    final bool hasPermissionToRecord = await recorder.hasPermission();

    if (hasPermissionToRecord) {
      await recorder
          .start(path: audioPath, encoder: AudioEncoder.wav)
          .then((_) {
        startTimer();
        setState(() => isRecording = true);
      });
    }
  }

  Future<void> stopRecording() async {
    await recorder.stop().then((data) {
      stopTimer();
      setState(() {
        isRecording = false;
        hasRecording = true;
        audioData = data;
      });
    });
  }

  void playRecordedAudio() async {
    player.open(Audio.file(audioPath));
  }

  Future<bool> saveRecordedAudio() async {
    final PermissionStatus permissionStatus =
        await Permission.storage.request();

    final bool hasPermissionToSaveRecording =
        permissionStatus == PermissionStatus.granted;

    if (hasPermissionToSaveRecording) {
      final Directory directory = await getDownloadDirectory();
      final int date = DateTime.now().microsecondsSinceEpoch;

      File(audioData!).copy('${directory.path}/${date}audiowave.wav');

      return true;
    } else {
      return false;
    }
  }

  Future<Directory> getDownloadDirectory() async {
    Directory? directory = await getExternalStorageDirectory();

    String newPath = '';

    final List<String> folders = directory!.path.split('/');

    for (int x = 1; x < folders.length; x++) {
      final String folder = folders[x];
      if (folder != 'Android') {
        newPath += '/$folder';
      }
      if (folder == 'Android') {
        break;
      }
    }
    newPath = '$newPath/Download';
    directory = Directory(newPath);

    bool isDirectoryExists = await directory.exists();

    if (!isDirectoryExists) {
      await directory.create(recursive: true);
    }

    return directory;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appPrimaryLighColor,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            AppIcon(iconColor: appSecondaryColor),
            SizedBox(width: 10),
            Text(appName),
            SizedBox(width: 20),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 80,
      ),
      body: Center(child: getMainDisplay()),
      floatingActionButton: isRecording
          ? RecordButton(onPressed: stopRecording, icon: squareIcon)
          : RecordButton(onPressed: startRecording, icon: roundIcon),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        color: appPrimaryDarkColor,
        child: SizedBox(
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AppButton(
                buttonText: 'Reset',
                onPressed: () {
                  setState(() => hasRecording = false);
                  player.stop();
                  showCustomToast('Recorded audio has been reset!', context);
                },
                disabled: !hasRecording,
              ),
              AppButton(
                buttonText: 'Save',
                onPressed: () async {
                  bool isSaved = await saveRecordedAudio();
                  if (isSaved) {
                    showCustomToast('Audio successfully saved!', context);
                  } else {
                    showCustomToast('Unable to save audio', context);
                  }
                },
                disabled: !hasRecording,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getMainDisplay() {
    if (isRecording) {
      return RecordProgressSection(secondsElapsed: secondsElapsed);
    }

    if (hasRecording) {
      return RecordSuccessSection(
        data: audioPathTimeStamp,
        file: File(audioData!),
        playRecordedAudio: playRecordedAudio,
      );
    }

    return const RecordInitialSection();
  }
}
