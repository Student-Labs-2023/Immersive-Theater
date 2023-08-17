import 'package:flutter/material.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/location_figure.dart';
import 'package:shebalin/src/theme/app_color.dart';

class LocationItem extends StatelessWidget {
  final String locationName;
  final bool isCurrentLocation;
  final bool isCompleted;
  const LocationItem({
    super.key,
    required this.locationName,
    required this.isCurrentLocation,
    required this.isCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 27,
                child: CustomPaint(
                  painter: LocationFigure(
                    isCurrentLocation: isCurrentLocation,
                    color: isCompleted ? AppColor.grey : AppColor.purplePrimary,
                    bias: 11,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 9,
              child: Text(
                locationName,
                style: Theme.of(context).textTheme.bodyMedium,
                maxLines: 3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
