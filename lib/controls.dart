import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_library/new_box.dart';

class Controls {
  Widget playButton(AudioPlayer audioPlayer) {
    return StreamBuilder<PlayerState>(
        stream: audioPlayer.playerStateStream,
        builder: (context, snapshot) {
          final playerState = snapshot.data;
          final procesingState = playerState?.processingState;
          final playing = playerState?.playing;
          if (!(playing ?? false)) {
            return NewBox(
              child: IconButton(
                onPressed: audioPlayer.play,
                iconSize: 80,
                icon: const Icon(Icons.play_arrow_rounded),
              ),
            );
          } else if (procesingState != ProcessingState.completed) {
            return NewBox(
                child: IconButton(
                    onPressed: audioPlayer.pause,
                    iconSize: 80,
                    icon: const Icon(Icons.pause_rounded)));
          }
          return const NewBox(
            child: Icon(
              Icons.play_arrow_rounded,
              size: 32,
              color: Colors.white,
            ),
          );
        });
  }
}
