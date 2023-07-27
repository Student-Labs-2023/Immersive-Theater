import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locations_repository/locations_repository.dart';
import 'package:shebalin/src/features/locations/bloc/location_bloc.dart';
import 'package:shebalin/src/features/locations/view/widgets/audio_content_location_panel.dart';
import 'package:shebalin/src/features/locations/view/widgets/header_content_location_panel.dart';
import 'package:shebalin/src/features/locations/view/widgets/historical_content_location_panel.dart';
import 'package:shebalin/src/features/locations/view/widgets/images_content_location_panel.dart';
import 'package:shebalin/src/features/main_screen/view/main_screen.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_button.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:shebalin/src/theme/ui/app_text_header.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../../../models/payment_model.dart';

class LocationDescriptionPanelPage extends StatefulWidget {
  const LocationDescriptionPanelPage({Key? key, required this.mapObjectId,})
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
      extendBody: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          _openYandexWidgetOnTap();
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
              mediaQuerySize.width * 0.85,
              mediaQuerySize.width * 0.13,
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppTextHeader(title: currentLocation.title),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              _closePanel();
                            },
                            child: const Image(
                              color: AppColor.grey,
                              image: AssetImage(ImagesSources.cancelLoc),
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
                      child: Text(
                        currentLocation.tag,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(color: AppColor.greyText),
                      ),
                    ),
                    ImagesContentLocationPanel(
                      imageLinks: currentLocation.imageLinks,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 16, right: 16, top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const AppTextHeader(title: 'Историческая справка'),
                          HistoricalContentLocationPanel(
                            locationDescription: currentLocation.description,
                          ),
                          const AppTextHeader(
                            title: 'Аудио отрывок',
                          ),
                          const SizedBox(
                            height: 12,
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
    context.read<MapPinBloc>().emit(MapPinClosingState());
  }
}
