import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shebalin/src/features/audioplayer/model/audio_panel_state.dart';
import 'package:shebalin/src/features/audioplayer/view/audioplayer_panel_page.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performances_page.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PerformanceDoubleScreen extends StatefulWidget {
  const PerformanceDoubleScreen({Key? key}) : super(key: key);
  static const routeName = '/perfomance-description-screen';
  @override
  State<PerformanceDoubleScreen> createState() =>
      _PerformanceDoubleScreenState();
}

class _PerformanceDoubleScreenState extends State<PerformanceDoubleScreen> {
  final panelController = PanelController();
  dynamic performance;
  @override
  Widget build(BuildContext context) {
    performance = ModalRoute.of(context)?.settings.arguments;
    return ChangeNotifierProvider(
      create: (context) => AudioPanelState(),
      builder: (context, child) {
        return SlidingUpPanel(
          body: PerfomanceDescriptionScreen(performance: performance),
          panel: AudioPlayerPanelPage(performance: performance),
          maxHeight: MediaQuery.of(context).size.height,
          minHeight: 0,
          controller: context.watch<AudioPanelState>().panelController,
          defaultPanelState: PanelState.CLOSED,
        );
      },
    );
  }
}
