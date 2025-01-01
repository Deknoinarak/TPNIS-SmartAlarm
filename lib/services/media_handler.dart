import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:tpnisalarm/stores/observable_alarm/observable_alarm.dart';
import 'package:vibration/vibration.dart';

import 'package:just_audio/just_audio.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class MediaHandler {
  late AudioPlayer _currentPlayer;
  Timer? volumeTimer;

  MediaHandler() {
    _currentPlayer = AudioPlayer();
  }

  /// Play device default alarm tone
  Future<void> playDeviceDefaultTone(ObservableAlarm alarm) async {
    await FlutterRingtonePlayer().play(
      android: AndroidSounds.alarm,
      ios: IosSounds.alarm,
      looping: true, // Android only - API >= 28
      volume: alarm.volume!, // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    );
  }

  /// This function initializes and play the sound player using a list of alarm sounds
  /// or it plays device default tone when no sound is specified in alarm.
  /// @param alarm - An ObservableAlarm object
  Future<void> playMusic(ObservableAlarm alarm) async {
    await playDeviceDefaultTone(alarm);

    debugPrint("vibration started");
    // Start vibration
    await Vibration.vibrate(
        pattern: [500, 1000, 500, 2000],
        repeat: 1,
        intensities: [1, 255, 1, 255]);
  }

  /// This function stops the music player
  Future<void> stopMusic() async {
    // Pause the music instead of stopping... Well i dunno whats up but the
    // developer of the player recommends it.
    if (_currentPlayer.playing) await _currentPlayer.pause();
    // Cancel progressive volume timer if active
    if (volumeTimer != null && volumeTimer!.isActive) volumeTimer!.cancel();
    // Stop default ringtone player if active
    await FlutterRingtonePlayer().stop();
    //Stop ongoing vibration.
    await Vibration.cancel();
  }

  /// This function increases the device volume progressively from
  /// low to highest pitch.
  /// @param volume - The initial volume
  Future<void> increaseVolumeProgressively(double volume) async {
    debugPrint("volume aaa: $volume");
    volumeTimer = Timer.periodic(Duration(seconds: 2), (timer) async {
      volume += 0.1;
      debugPrint("volume: $volume");
      if (volume == 1) {
        // Max volume reached
        timer.cancel();
      } else {
        //   print("volume: $volume");
        // Increase the volume
        await _currentPlayer.setVolume(volume);
      }
    });
  }
}
