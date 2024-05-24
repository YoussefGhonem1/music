import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/song_model.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart' as rxdart;
import 'package:music/widgets.dart';

class SongScreen extends StatefulWidget {
  const SongScreen({
    super.key,
    // required this.i,
  });
//final i;

  @override
  State<SongScreen> createState() => _SongScreenState();
}

class _SongScreenState extends State<SongScreen> {
  AudioPlayer audioPlayer = AudioPlayer();
  int a = Random().nextInt(Song.songs.length - 1);
  int check = i;
  static int get i => Random().nextInt(Song.songs.length - 1);
  void checking() {
    while (check == i) {
      int i = Random().nextInt(Song.songs.length - 1);
    }
  }
  Song song = Get.arguments ?? Song.songs[i];

  @override
  void initState() {
    super.initState();
    audioPlayer.setAudioSource(
      ConcatenatingAudioSource(
        children: [
          AudioSource.uri(
            Uri.parse('asset:///${song.url}'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    audioPlayer.dispose();
  }

  Stream<SeekBarData> get _SeekBarDataStream =>
      rxdart.Rx.combineLatest2<Duration, Duration?, SeekBarData>(
          audioPlayer.positionStream, audioPlayer.durationStream, (
        Duration position,
        Duration? duration,
      ) {
        return SeekBarData(
          position,
          duration ?? Duration.zero,
        );
      });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            song.coverUrl,
            fit: BoxFit.cover,
          ),
          const _BackgroundFilter(),
          _MusicPlayer(
              song: song,
              SeekBarDataStream: _SeekBarDataStream,
              audioPlayer: audioPlayer),
        ],
      ),
    );
  }
}

class _MusicPlayer extends StatefulWidget {
  _MusicPlayer({
    super.key,
    required this.song,
    required Stream<SeekBarData> SeekBarDataStream,
    required this.audioPlayer,
  }) : _SeekBarDataStream = SeekBarDataStream;
  final Song song;
  final Stream<SeekBarData> _SeekBarDataStream;
  final AudioPlayer audioPlayer;

  @override
  State<_MusicPlayer> createState() => _MusicPlayerState();
}

class _MusicPlayerState extends State<_MusicPlayer> {
  final List<double> items = [
    0.5,
    1,
    1.5,
    2,
  ];

  String? selectedValue;

  double speedd = 1;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.song.title,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(
            height: 30,
          ),
          StreamBuilder<SeekBarData>(
              stream: widget._SeekBarDataStream, //s
              builder: (context, snapshot) {
                final positionData = snapshot.data;
                return SeekBar(
                  position: positionData?.position ?? Duration.zero,
                  duration: positionData?.duration ?? Duration.zero,
                  onChangeEnd: widget.audioPlayer.seek,
                );
              }),
          PlayerButtons(audioPlayer: widget.audioPlayer),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DropdownButton<String>(
                dropdownColor: Colors.grey.shade900,
                hint: const Text(
                  'Speed',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                icon: const Icon(Icons.speed),
                underline: Container(
                  height: 0.5,
                  color: Colors.white,
                ),
                items: items
                    .map((double item) => DropdownMenuItem<String>(
                          value: "$item",
                          child: Text(
                            "$item",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    if (value == "0.5") {
                      widget.audioPlayer.setSpeed(0.5);
                    } else if (value == "1.0") {
                      widget.audioPlayer.setSpeed(1);
                    } else if (value == "1.5") {
                      widget.audioPlayer.setSpeed(1.5);
                    } else if (value == "2.0") {
                      widget.audioPlayer.setSpeed(2);
                    }
                    selectedValue = value;
                  });
                },
                value: selectedValue,
              ),
              IconButton(
                iconSize: 35,
                onPressed: () {},
                icon: const Icon(
                  Icons.cloud_download,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BackgroundFilter extends StatelessWidget {
  const _BackgroundFilter({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (rect) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Colors.white.withOpacity(0.5),
              Colors.white.withOpacity(0.0),
            ],
            stops: const [
              0.0,
              0.4,
              0.6
            ]).createShader(rect);
      },
      blendMode: BlendMode.dstOut,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey.shade300,
              Colors.black,
            ],
          ),
        ),
      ),
    );
  }
}
