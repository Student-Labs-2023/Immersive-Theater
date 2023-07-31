import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:intl/date_symbol_data_local.dart';

import '../../../theme/theme.dart';

class AudioPlayerPanelPage extends StatefulWidget {
  const AudioPlayerPanelPage({Key? key, required this.performance})
      : super(key: key);
  final Performance performance;
  @override
  State<AudioPlayerPanelPage> createState() => _AudioPlayerPanelPageState();
}

class _AudioPlayerPanelPageState extends State<AudioPlayerPanelPage>
    with SingleTickerProviderStateMixin {
  late dynamic playlist;

  final audioPlayer = AudioPlayer();
  late AnimationController _animationController;
  bool isPlaying = false;
  bool isPlayingForAnimation = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  double textOfAudioButtonOpacity = 0.4;
  double bluetoothButtonOpacity = 0.4;
  double playlistButtonOpacity = 0.4;

  @override
  void initState() {
    super.initState();
    playlist = ConcatenatingAudioSource(
      useLazyPreparation: true,
      children: widget.performance.chapters
          .map<AudioSource>(
            (chapter) => AudioSource.uri(Uri.parse(chapter.shortAudioLink)),
          )
          .toList(),
    );
    initializeDateFormatting();
    audioPlayer.setVolume(1.0);
    audioPlayer.setSpeed(1.0);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    setAudio();

    audioPlayer.playerStateStream.listen((state) {
      if (mounted) {
        setState(() {
          isPlaying = state == PlayerState(true, ProcessingState.ready);
        });
      }
    });

    audioPlayer.durationStream.listen((newDuration) {
      if (mounted) {
        setState(() {
          if (newDuration != null) {
            duration = newDuration;
          }
        });
      }
    });

    audioPlayer.positionStream.listen((newPosition) {
      if (mounted) {
        setState(() {
          position = newPosition;
        });
      }
    });
  }

  Future setAudio() async {
    await audioPlayer.setAudioSource(
      playlist,
      initialIndex: 0,
      preload: false,
      initialPosition: Duration.zero,
    );
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 156, 144, 134),
              Color.fromARGB(255, 101, 79, 66),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(
                height: 12,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: containerRadius,
                ),
                child: SizedBox(
                  height: 3,
                  width: MediaQuery.of(context).size.width * 0.07,
                ),
              ),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(24.0)),
                ),
                clipBehavior: Clip.hardEdge,
                margin: const EdgeInsets.all(32),
                height: MediaQuery.of(context).size.height * 0.38,
                width: MediaQuery.of(context).size.width * 0.85,
                child: CachedNetworkImage(
                  placeholder: (context, string) =>
                      const CircularProgressIndicator(
                    color: AppColor.grey,
                  ),
                  imageUrl: widget.performance.imageLink,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(32, 0, 0, 24),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.performance.chapters[audioPlayer.currentIndex!]
                              .title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          widget.performance.title,
                          style:
                              Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: Colors.white.withOpacity(0.4),
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Slider(
                      thumbColor: Colors.white,
                      activeColor: Colors.white,
                      inactiveColor: Colors.white.withOpacity(0.25),
                      min: 0,
                      max: duration.inSeconds.toDouble(),
                      value: position.inSeconds.toDouble(),
                      onChanged: (value) async {
                        final position = Duration(seconds: value.toInt());
                        await audioPlayer.seek(position);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            formatTime(position),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.4),
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            formatTime(duration - position),
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                                  color: Colors.white.withOpacity(0.4),
                                  fontWeight: FontWeight.w600,
                                ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () => _skipPreviousOnPressed(),
                      color: audioPlayer.currentIndex == 0
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white,
                      icon: const Icon(Icons.skip_previous),
                      iconSize: 48,
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    IconButton(
                      onPressed: () => _playPauseButtonOnPressed(),
                      color: Colors.white,
                      icon: AnimatedIcon(
                        icon: AnimatedIcons.play_pause,
                        progress: _animationController,
                      ),
                      iconSize: 48,
                    ),
                    const SizedBox(
                      width: 28,
                    ),
                    IconButton(
                      onPressed: audioPlayer.currentIndex == playlist.length - 1
                          ? () {}
                          : () => _skipNextOnPressed(),
                      color: audioPlayer.currentIndex == playlist.length - 1
                          ? Colors.white.withOpacity(0.3)
                          : Colors.white,
                      icon: const Icon(Icons.skip_next),
                      iconSize: 48,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () => _changeButtonOpacity(
                        opacity: textOfAudioButtonOpacity,
                        buttonName: ButtonName.textOfAudio,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 28,
                        child: Image(
                          color: Color.fromRGBO(
                            255,
                            255,
                            255,
                            textOfAudioButtonOpacity,
                          ),
                          fit: BoxFit.contain,
                          image: const AssetImage(ImagesSources.textOfAudio),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => _changeButtonOpacity(
                        opacity: bluetoothButtonOpacity,
                        buttonName: ButtonName.bluetooth,
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 28,
                        child: Image(
                          color: Color.fromRGBO(
                            255,
                            255,
                            255,
                            bluetoothButtonOpacity,
                          ),
                          fit: BoxFit.contain,
                          image: const AssetImage(ImagesSources.bluetooth),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () => (_changeButtonOpacity(
                        opacity: playlistButtonOpacity,
                        buttonName: ButtonName.playlist,
                      )),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width / 3,
                        height: 28,
                        child: Image(
                          color: Color.fromRGBO(
                            255,
                            255,
                            255,
                            playlistButtonOpacity,
                          ),
                          fit: BoxFit.contain,
                          image: const AssetImage(ImagesSources.playlist),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _skipNextOnPressed() async {
    await audioPlayer.seekToNext();
  }

  void _skipPreviousOnPressed() async {
    if (position > const Duration(seconds: 5) ||
        audioPlayer.currentIndex == 0) {
      position = Duration.zero;
      await audioPlayer.seek(position);
      return;
    }
    await audioPlayer.seekToPrevious();
  }

  void _playPauseButtonOnPressed() async {
    setState(() {
      isPlayingForAnimation = !isPlayingForAnimation;
      isPlayingForAnimation
          ? _animationController.forward()
          : _animationController.reverse();
    });
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }
  }

  String formatTime(Duration duration) {
    return DateFormat.ms('ru')
        .format(DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds))
        .toString();
  }

  void _changeButtonOpacity({
    required double opacity,
    required Enum buttonName,
  }) {
    switch (buttonName) {
      case ButtonName.textOfAudio:
        {
          setState(() {
            opacity == 0.4
                ? textOfAudioButtonOpacity = 1
                : textOfAudioButtonOpacity = 0.4;
          });
          break;
        }
      case ButtonName.bluetooth:
        {
          setState(() {
            if (opacity == 0.4) {
              bluetoothButtonOpacity = 1;
            } else {
              (bluetoothButtonOpacity = 0.4);
            }
          });
          break;
        }
      case ButtonName.playlist:
        {
          setState(() {
            if (opacity == 0.4) {
              playlistButtonOpacity = 1;
            } else {
              (playlistButtonOpacity = 0.4);
            }
          });
          break;
        }
    }
  }
}

enum ButtonName { textOfAudio, bluetooth, playlist }
