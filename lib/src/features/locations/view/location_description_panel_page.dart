import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/locations/bloc/location_bloc.dart';
import 'package:shebalin/src/features/locations/view/widgets/audio_content_location_panel.dart';
import 'package:shebalin/src/features/locations/view/widgets/header_content_location_panel.dart';
import 'package:shebalin/src/features/locations/view/widgets/historical_content_location_panel.dart';
import 'package:shebalin/src/features/locations/view/widgets/images_content_location_panel.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';
import '../../../models/payment_model.dart';
import '../../detailed_performaces/view/performance_double_screen.dart';

class LocationDescriptionPanelPage extends StatefulWidget {
  const LocationDescriptionPanelPage({Key? key, required this.mapObjectId})
      : super(key: key);
  final String mapObjectId;

  @override
  State<LocationDescriptionPanelPage> createState() =>
      _LocationDescriptionPanelPageState();
}

class _LocationDescriptionPanelPageState
    extends State<LocationDescriptionPanelPage> {
  Payment paymentService = Payment();
  late Location currentLocation;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AppButton(
        buttonTitle: "Перейти к спектаклю",
        onButtonClickFunction: () => Navigator.of(context).pushNamed(
            PerformanceDoubleScreen.routeName,
            arguments: 0 //TODO: сделать прееход к экрану спектакля
            ),
        width: mediaQuerySize.width * 0.85,
        height: mediaQuerySize.width * 0.11,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: SingleChildScrollView(
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationsLoadInProgress) {
                return Center(
                  child: CircularProgressIndicator(color: accentTextColor),
                );
              }
              if (state is LocationsLoadSuccess) {
                currentLocation = state.locations[state.locations.indexWhere(
                  (location) => location.number == widget.mapObjectId,
                )];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          HeaderContentLocationPanel(
                            locationTitle: currentLocation.title,
                            locationTag: currentLocation.tag,
                          ),
                          Row(
                            children: [
                              const SizedBox(
                                width: 24,
                              ),
                              InkWell(
                                onTap: () {
                                  _closePanel();
                                },
                                child: const Image(
                                  image: AssetImage(ImagesSources.cancelLoc),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    ImagesContentLocationPanel(
                      imageLinks: currentLocation.imageLinks,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppTextHeader(title: 'Историческая справка'),
                          HistoricalContentLocationPanel(
                            locationDescription: currentLocation.description,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const AppTextHeader(
                            title: 'Аудио отрывок',
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          const AudioContentLocationPanel(),
                        ],
                      ),
                    ),
                  ],
                );
              }
              return const Text('Что-то не так');
            },
          ),
        ),
      ),
    );
  }

  void _openYandexWidgetOnTap() async {
    //ссылка на виджет
  }

  void _closePanel() {
    context.read<MapPinBloc>().add(CloseMapPin());
  }
}
