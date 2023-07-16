import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/mode_performance/bloc/mode_performance_bloc.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/images_location.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/location_item.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/bar_indicator.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class PanelWidget extends StatefulWidget {
  final PanelController controller;
  final List<Location> locations;
  const PanelWidget({
    super.key,
    required this.controller,
    required this.locations,
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
        const BarIndicator(),
        const SizedBox(
          height: 20,
        ),
        Visibility(
          visible: widget.controller.isPanelClosed,
          child: BlocBuilder<ModePerformanceBloc, ModePerformanceState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: ImagesLocation(
                  imageLinks: widget.locations[state.indexLocation].imageLinks,
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
            Image.asset(
              widget.controller.isPanelOpen
                  ? ImagesSources.downIcon
                  : ImagesSources.upIcon,
            ),
          ],
        ),
        const SizedBox(
          height: 12,
        ),
        Flexible(
          child: BlocBuilder<ModePerformanceBloc, ModePerformanceState>(
            builder: (context, state) {
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: widget.locations.length,
                itemBuilder: (context, index) {
                  return LocationItem(
                    locationName: widget.locations[index].title,
                    isCurrentLocation: state.indexLocation == index,
                    isCompleted: index < state.indexLocation,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
