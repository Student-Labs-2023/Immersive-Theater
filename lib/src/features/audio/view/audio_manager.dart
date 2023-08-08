import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/audio/bloc/audio_manager_bloc.dart';
import 'package:shebalin/src/features/audio/view/widgets/audio_widget.dart';

class AudioManager extends StatefulWidget {
  final List<Chapter> chapters;
  final String subtitle;
  final AudioManagerBloc bloc;
  final double width;

  const AudioManager({
    super.key,
    required this.chapters,
    required this.bloc,
    required this.subtitle,
    required this.width,
  });

  @override
  State<AudioManager> createState() => _AudioManagerState();
}

class _AudioManagerState extends State<AudioManager> {
  @override
  void initState() {
    widget.bloc.add(
      AudioManagerAddAudio(
        audioLinks: widget.chapters.map((e) => e.shortAudioLink).toList(),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioManagerBloc, AudioManagerState>(
      bloc: widget.bloc,
      builder: (BuildContext context, state) {
        return GridView(
          scrollDirection: Axis.horizontal,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            mainAxisExtent: widget.width,
          ),
          children: List.generate(
            widget.chapters.length,
            (index) => SizedBox(
              width: widget.width,
              child: AudioWidget(
                onTap: () => _onTap(index),
                isCurrent: index == state.index,
                isPlaying: index == state.index,
                title: 'Глава ${index + 1}',
                subtitle: widget.subtitle,
                image: widget.chapters[index].images[0],
                duration: '1:04',
                progress: index == state.index ? state.progress : 0,
              ),
            ),
          ),
        );
      },
    );
  }

  void _onTap(int index) {
    widget.bloc.add(
      AudioManagerChangeCurrentAudio(
        indexAudio: index,
        url: '',
      ),
    );
  }
}
