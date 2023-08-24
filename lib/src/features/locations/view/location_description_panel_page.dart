import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/audio/bloc/audio_manager_bloc.dart';
import 'package:shebalin/src/features/audio/view/widgets/audio_widget.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performance_args.dart';
import 'package:shebalin/src/features/detailed_performaces/view/detailed_performance_page.dart';
import 'package:shebalin/src/features/locations/view/widgets/historical_content_location_panel.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';
import 'package:shebalin/src/theme/ui/skeleton_loaders.dart';
import 'package:shebalin/src/features/locations/view/widgets/images_content_location_panel.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';

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
  late Chapter currentLocation;
  late final AudioManagerBloc _bloc;
  late String title;
  @override
  void initState() {
    _bloc = AudioManagerBloc();
    initializeDateFormatting();
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
            return Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
              child: AppButton.primaryButton(
                title: 'Перейти к спектаклю',
                onTap: () async {
                  final int index = int.parse(
                    widget.mapObjectId
                        .substring(0, widget.mapObjectId.indexOf('/')),
                  );
                  _bloc.add(const AudioManagerAudioCompleted());
                  Navigator.of(context).pushNamed(
                    DetailedPerformancePage.routeName,
                    arguments: DetailedPerformanceArgs(
                      performance: state.perfomances[index],
                    ),
                  );
                },
              ),
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.only(top: 12, left: 16),
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
              _bloc.add(
                AudioManagerAddAudio(
                  audioLinks: [currentLocation.shortAudioLink],
                ),
              );
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 16),
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
                      top: 8,
                      bottom: 20,
                    ),
                    child: isLoaded
                        ? Text(
                            currentLocation.place.address,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: AppColor.greyText,
                                ),
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
                      : PhotosSkeleton(
                          photoHeight: mediaQuerySize.height * 0.108,
                          photoWidth: mediaQuerySize.width * 0.234,
                        ),
                  const SizedBox(
                    height: 12,
                  ),
                  const AppTextHeader(title: 'Историческая справка'),
                  const SizedBox(
                    height: 8,
                  ),
                  isLoaded
                      ? Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: HistoricalContentLocationPanel(
                            locationDescription: state
                                .perfomances[int.parse(
                              widget.mapObjectId.substring(
                                0,
                                widget.mapObjectId.indexOf('/'),
                              ),
                            )]
                                .info
                                .description,
                          ),
                        )
                      : const HistoricalContentSkeleton(),
                  const AppTextHeader(
                    title: 'Аудио отрывок',
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  isLoaded
                      ? BlocBuilder<AudioManagerBloc, AudioManagerState>(
                          bloc: _bloc,
                          builder: (context, state) {
                            return Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: AudioWidget(
                                title: 'Глава ${int.parse(
                                      widget.mapObjectId.substring(
                                        widget.mapObjectId.indexOf('/') + 1,
                                      ),
                                    ) + 1}',
                                subtitle: context
                                    .read<PerformanceBloc>()
                                    .state
                                    .perfomances[int.parse(
                                      widget.mapObjectId.substring(
                                        0,
                                        widget.mapObjectId.indexOf('/'),
                                      ),
                                    )]
                                    .title,
                                image: currentLocation.images[0],
                                duration: state is AudioManagerInitial
                                    ? ''
                                    : _bloc.getDuration(0),
                                isCurrent: state.index == 0,
                                onTap: _onAudioTap,
                                progress: state.progress,
                              ),
                            );
                          },
                        )
                      : const AudioCardSkeleton(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  void _closePanel() {
    context.read<MapPinBloc>().add(CloseMapPin());
    Navigator.of(context).popUntil(ModalRoute.withName(MainScreen.routeName));
  }

  void _onAudioTap() {
    _bloc.add(
      AudioManagerSetAudio(
        indexAudio: 0,
        url: currentLocation.shortAudioLink,
      ),
    );
  }

  @override
  void dispose() {
    _bloc.add(const AudioManagerAudioCompleted());
    super.dispose();
  }
}
