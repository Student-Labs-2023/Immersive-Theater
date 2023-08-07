import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/detailed_performaces/view/performance_double_screen.dart';
import 'package:shebalin/src/theme/ui/skeleton_loaders.dart';
import 'package:shebalin/src/features/locations/view/widgets/audio_content_location_panel.dart';
import 'package:shebalin/src/features/locations/view/widgets/historical_content_location_panel.dart';
import 'package:shebalin/src/features/locations/view/widgets/images_content_location_panel.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';
import '../../../models/payment_model.dart';

class LocationDescriptionPanelPage extends StatefulWidget {
  const LocationDescriptionPanelPage({
    Key? key,
    required this.mapObjectId,
  }) : super(key: key);
  final String mapObjectId;
  @override
  State<LocationDescriptionPanelPage> createState() =>
      _LocationDescriptionPanelPageState();
}

class _LocationDescriptionPanelPageState
    extends State<LocationDescriptionPanelPage> {
  Payment paymentService = Payment();
  late Chapter currentLocation;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      floatingActionButton: BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
          if (state is PerformanceLoadSuccess) {
            return ElevatedButton(
              onPressed: () async {
                final int index = int.parse(
                  widget.mapObjectId
                      .substring(0, widget.mapObjectId.indexOf('/')),
                );
                Navigator.of(context).pushNamed(
                  PerformanceDoubleScreen.routeName,
                  arguments: state.perfomances[index],
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(accentTextColor),
                elevation: MaterialStateProperty.all(5),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                minimumSize: MaterialStateProperty.all(
                  Size(
                    mediaQuerySize.width - 32,
                    48,
                  ),
                ),
              ),
              child: Text(
                'Перейти к спектаклю',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppColor.whiteText),
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SingleChildScrollView(
          child: BlocBuilder<PerformanceBloc, PerformanceState>(
            builder: (context, state) {
              final bool isLoaded = state is PerformanceLoadSuccess;
              final int index = int.parse(
                widget.mapObjectId
                    .substring(0, widget.mapObjectId.indexOf('/')),
              );
              final int indexPlace = int.parse(
                widget.mapObjectId
                    .substring(widget.mapObjectId.indexOf('/') + 1),
              );
              currentLocation =
                  state.perfomances[index].info.chapters[indexPlace];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        isLoaded
                            ? AppTextHeader(title: currentLocation.title)
                            : Container(
                                width: mediaQuerySize.width * 0.58,
                                height: mediaQuerySize.height * 0.02,
                                decoration: BoxDecoration(
                                  color: AppColor.greySkeleton,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            _closePanel();
                          },
                          child: Image.asset(
                            ImagesSources.cross,
                            height: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 16,
                      top: 8,
                      bottom: 20,
                    ),
                    child: isLoaded
                        ? Text(
                            currentLocation.place.address,
                            style: Theme.of(context)
                                .textTheme
                                .labelSmall
                                ?.copyWith(color: AppColor.greyText),
                          )
                        : Container(
                            width: mediaQuerySize.width * 0.34,
                            height: mediaQuerySize.height * 0.017,
                            decoration: BoxDecoration(
                              color: AppColor.greySkeleton,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                  ),
                  isLoaded
                      ? ImagesContentLocationPanel(
                          imageLinks: currentLocation.images,
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: PhotosSkeleton(
                            photoHeight: mediaQuerySize.height * 0.108,
                            photoWidth: mediaQuerySize.width * 0.234,
                          ),
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const AppTextHeader(title: 'Историческая справка'),
                        isLoaded
                            ? HistoricalContentLocationPanel(
                                locationDescription: currentLocation.title,
                              )
                            : const HistoricalContentSkeleton(),
                        const AppTextHeader(
                          title: 'Аудио отрывок',
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        isLoaded
                            ? const AudioContentLocationPanel()
                            : const AudioCardSkeleton(),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _closePanel() {
    context.read<MapPinBloc>().emit(MapPinClosingState());
  }
}
