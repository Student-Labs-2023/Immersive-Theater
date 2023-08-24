import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/map_performance/bloc/perf_mode_map_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/images_location.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/location_item.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_animated_visibility.dart';
import 'package:shebalin/src/theme/ui/app_resize_handler.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatefulWidget {
  final PanelController controller;
  final List<Chapter> chapters;
  final void Function(List<String>, int) onImageOpen;
  const PanelWidget({
    super.key,
    required this.controller,
    required this.chapters,
    required this.onImageOpen,
  });

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 12,
        ),
        const AppResizeHandler(),
        const SizedBox(
          height: 20,
        ),
        AppAnimatedVisibility(
          isVisible: !widget.controller.isPanelOpen,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeIn,
          child: BlocBuilder<PerfModeBloc, PerfModeState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ImagesLocation(
                  imageLinks: widget.chapters[state.indexLocation].images,
                  onTap: widget.onImageOpen,
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 16,
            ),
            Text(
              "Маршрут",
              style: Theme.of(context)
                  .textTheme
                  .displaySmall!
                  .copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              width: 13,
            ),
            AnimatedRotation(
              turns: widget.controller.isPanelOpen ? 0.5 : 0,
              duration: const Duration(
                milliseconds: 300,
              ),
              child: Image.asset(
                ImagesSources.upIcon,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        BlocBuilder<PerfModeBloc, PerfModeState>(
          builder: (context, state) {
            return ListView.builder(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemCount: widget.chapters.length,
              itemBuilder: (context, index) {
                return LocationItem(
                  locationName: widget.chapters[index].place.title,
                  isCurrentLocation: state.indexLocation == index,
                  isCompleted: index < state.indexLocation,
                );
              },
            );
          },
        ),
      ],
    );
  }
}
