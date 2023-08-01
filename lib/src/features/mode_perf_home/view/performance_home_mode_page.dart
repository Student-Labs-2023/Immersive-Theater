import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/audio_player/view/audio_player.dart';
import 'package:shebalin/src/features/audio_player/bloc/audio_player_bloc.dart';
import 'package:shebalin/src/features/mode_perf_home/bloc/perf_home_mode_bloc.dart';
import 'package:shebalin/src/features/mode_perf_home/view/widgets/home_map_page.dart';
import 'package:shebalin/src/features/mode_perf_home/view/widgets/panel_widget.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/dialog_window.dart';
import 'package:shebalin/src/features/mode_performance_flow/models/current_performance_provider.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PerformanceAtHomeModePage extends StatefulWidget {
  static const routeName = 'mode-home';
  final VoidCallback onPerfModeComplete;
  final VoidCallback onPerfModeResume;
  final void Function(List<String>, int) onImageOpen;
  const PerformanceAtHomeModePage({
    super.key,
    required this.onPerfModeComplete,
    required this.onPerfModeResume,
    required this.onImageOpen,
  });

  @override
  State<PerformanceAtHomeModePage> createState() =>
      _PerformanceAtHomeModePageState();
}

class _PerformanceAtHomeModePageState extends State<PerformanceAtHomeModePage> {
  late double heightButton = 3.0;
  final panelController = PanelController();
  late List<Chapter> chapters;
  @override
  void initState() {
    chapters = RepositoryProvider.of<CurrentPerformanceProvider>(context)
        .performance
        .chapters;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double heightPanelOpened = height * 0.5;

    final double heightPanelClosed = height * 0.17;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: "closePerformance",
        backgroundColor: Colors.white,
        onPressed: () => _closePerformance(context),
        child: const Image(
          image: AssetImage(ImagesSources.closePerformance),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      extendBodyBehindAppBar: true,
      body: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SlidingUpPanel(
            backdropEnabled: true,
            controller: panelController,
            parallaxEnabled: true,
            parallaxOffset: .5,
            minHeight: heightPanelClosed,
            maxHeight: heightPanelOpened,
            borderRadius: panelRadius,
            panelBuilder: (scrollController) => HomeModePanelWidget(
              controller: panelController,
              chapters: chapters,
              onImageOpen: widget.onImageOpen,
            ),
            body: HomeMapPage(
              locations: chapters.map((e) => e.place).toList(),
              initialCoords: Point(
                latitude: chapters[0].place.latitude,
                longitude: chapters[0].place.longitude,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocConsumer<PerfHomeModeBloc, PerfHomeModeState>(
        listenWhen: (previous, current) {
          return previous.indexLocation < current.indexLocation;
        },
        listener: (context, state) {
          context.read<AudioPlayerBloc>().add(
                AudioPlayerAddPlaylistEvent(
                  audio: chapters[state.indexLocation].audioLink,
                ),
              );
        },
        builder: (context, state) {
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            constraints: const BoxConstraints(maxHeight: 150, maxWidth: 400),
            child: AudioPlayerPanel(indexLocation: state.indexLocation),
          );
        },
      ),
    );
  }

  void _closePerformance(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => DialogWindow(
        title: "Завершить спектакль?",
        subtitle: "Прогресс прохождения не будет\nсохранен.",
        onTapPrimary: widget.onPerfModeComplete,
        titlePrimary: "Завершить",
        titleSecondary: "Отмена",
        onTapSecondary: widget.onPerfModeResume,
      ),
    );
  }
}
