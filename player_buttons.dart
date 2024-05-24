import 'dart:math';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music/empty.dart';
import 'package:music/song_model.dart';
import 'package:get/get.dart';
import 'package:music/song_screen.dart';

class PlayerButtons extends StatelessWidget {
  const PlayerButtons({
    super.key,
    required this.audioPlayer,
  });
   get song => null;
  final AudioPlayer audioPlayer;
  @override
  Widget build(BuildContext context) {
   audioPlayer.play();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder<SequenceState?>(
            stream: audioPlayer.sequenceStateStream,
            builder: (context, index) {
              return IconButton(
                onPressed: () {
                  //empty().build(context);
                  // audioPlayer.seekToNext ,
                 //  var i = Random().nextInt(Song.songs.length - 1);
                  //var oo = Song.songs[i];
                   // Get.toNamed('/song', arguments: song);
                    //audioPlayer.hasPrevious ? audioPlayer.seekToPrevious : null,
                  audioPlayer.pause();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>  const SongScreen()),
                    );},
                iconSize: 45,
                icon: const Icon(
                  Icons.skip_previous,
                  color: Colors.white,
                ),
              );
            }),
        StreamBuilder<PlayerState>(
            stream: audioPlayer.playerStateStream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final playerState = snapshot.data;
                final processingState = playerState!.processingState;
                if (processingState == ProcessingState.loading ||
                    processingState == ProcessingState.buffering) {
                  return Container(
                    width: 64.0,
                    height: 64.0,
                    child: const CircularProgressIndicator(),
                  );
                } else if (!audioPlayer.playing) {
                  return IconButton(
                    onPressed: audioPlayer.play,
                    iconSize: 75,
                    icon: const Icon(
                      Icons.play_circle,
                      color: Colors.white,
                    ),
                  );
                } else if (processingState != ProcessingState.completed) {
                  return IconButton(
                    onPressed: audioPlayer.pause,
                    iconSize: 75.0,
                    icon: const Icon(
                      Icons.pause_circle,
                      color: Colors.white,
                    ),
                  );
                } else {
                  return IconButton(
                    onPressed: () => audioPlayer.seek(Duration.zero,
                        index: audioPlayer.effectiveIndices!.first),
                    iconSize: 75,
                    icon: const Icon(
                      Icons.replay_circle_filled_outlined,
                      color: Colors.white,
                    ),
                  );
                }
              } else {
                return const CircularProgressIndicator();
              }
            }),
        StreamBuilder<SequenceState?>(
            stream: audioPlayer.sequenceStateStream,
            builder: (context, index) {
              return IconButton(
                onPressed: () {
                  //empty().build(context);
                  // audioPlayer.seekToNext ,
                 //  var i = Random().nextInt(Song.songs.length - 1);
                  //var oo = Song.songs[i];
                   // Get.toNamed('/song', arguments: song);
                  audioPlayer.pause();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) =>  const SongScreen()),
                   );
                },
                iconSize: 45,
                icon: const Icon(
                  Icons.skip_next,
                  color: Colors.white,
                ),
              );
            }),
      ],
    );
  }
}
