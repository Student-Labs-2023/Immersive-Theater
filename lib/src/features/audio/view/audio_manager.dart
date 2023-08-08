import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/audio/bloc/audio_manager_bloc.dart';
import 'package:shebalin/src/features/audio/view/widgets/audio_widget.dart';

class AudioManager extends StatefulWidget {
  final List<Chapter> chapters;
  final AudioManagerBloc bloc;

  const AudioManager({super.key, required this.chapters, required this.bloc});

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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.2,
          ),
          children: List.generate(
            widget.chapters.length,
            (index) => AudioWidget(
              onTap: () => _onTap(index),
              isCurrent: index == state.index,
              isPlaying: index == state.index,
              title: widget.chapters[index].title,
              subtitle: widget.chapters[index].title,
              image: widget.chapters[index].images[0],
              duration: '1: 02',
              height: 40,
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
