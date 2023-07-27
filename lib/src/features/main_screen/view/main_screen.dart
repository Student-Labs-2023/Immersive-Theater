import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/locations/bloc/location_bloc.dart';
import 'package:shebalin/src/features/locations/view/location_description_panel_page.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/map/view/yandex_map_page.dart';
import 'package:shebalin/src/features/performances/view/performances_panel_page.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/input_promocode_panel_page.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_panel_page.dart';
import 'package:shebalin/src/features/user/view/personal_panel_page.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

import 'package:shebalin/src/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/main-screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final panelController = PanelController();
  bool isPerfomnceButtonPressed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: SlidingUpPanel(
        controller: panelController,
        defaultPanelState: PanelState.CLOSED,
        minHeight: MediaQuery.of(context).size.height * 0.12,
        maxHeight: context.watch<MapPinBloc>().state is MapPinLoaded
            ? MediaQuery.of(context).size.height * 0.63
            : MediaQuery.of(context).size.height * 0.85,
        header: BlocConsumer<MapPinBloc, MapPinState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MapPinInitialState || state is MapPinClosingState) {
              return Column(
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.12),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const SizedBox(
                            height: 3,
                            width: 25,
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextButton(
                          onPressed: () {
                            _isPerformancePanelShowed(true);
                            panelController.open();
                          },
                          child: Text(
                            "Спектакли",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isPerfomnceButtonPressed
                                      ? AppColor.blackText
                                      : AppColor.greyText,
                                ),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: TextButton(
                          onPressed: () {
                            _isPerformancePanelShowed(false);
                            panelController.open();
                          },
                          child: Text(
                            "Мои билеты",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: isPerfomnceButtonPressed
                                      ? AppColor.greyText
                                      : AppColor.blackText,
                                ),
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 20)),
                    ],
                  ),
                ],
              );
            } else if (state is MapPinLoadingState || state is MapPinLoaded) {
              return Column(
                children: [
                  const Padding(padding: EdgeInsets.fromLTRB(0, 20, 0, 8)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 - 25,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.12),
                          borderRadius: containerRadius,
                        ),
                        child: const SizedBox(
                          height: 3,
                          width: 25,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
            return const Text('Упс...Что-то пошло не так');
          },
        ),
        panel: BlocConsumer<MapPinBloc, MapPinState>(
          listener: (context, state) {},
          builder: (context, state) {
            if (state is MapPinInitialState) {
              return isPerfomnceButtonPressed
                  ? const PerformancesPanelPage()
                  : const PromocodePanelPage();
            } else if (state is MapPinLoadingState) {
              return Center(
                child: CircularProgressIndicator(color: accentTextColor),
              );
            } else if (state is MapPinLoaded) {
              Future.delayed(const Duration(milliseconds: 100), () {
                panelController.open();
              });
              return Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: LocationDescriptionPanelPage(
                  mapObjectId: state.mapObject.mapId.value,
                ),
              );
            } else if (state is MapPinClosingState) {
              // Future.delayed(const Duration(seconds: 1), () {
              //   panelController.close();
              // });
              return isPerfomnceButtonPressed
                  ? const PerformancesPanelPage()
                  : const PromocodePanelPage();
            }
            return const Text('Упс...Что-то пошло не так');
          },
        ),
        body: Center(
          child: BlocBuilder<LocationBloc, LocationState>(
            builder: (context, state) {
              if (state is LocationsLoadInProgress) {
                return const CircularProgressIndicator();
              } else if (state is LocationsLoadSuccess) {
                var locations = state.locations;
                return YandexMapPage(
                  locations: locations,
                );
              } else {
                return const Text("error");
              }
            },
          ),
        ),
        borderRadius: panelRadius,
        backdropEnabled: true,
        parallaxEnabled: true,
        parallaxOffset: 0.05,
      ),
    );
  }

  void _isPerformancePanelShowed(bool flag) {
    if (isPerfomnceButtonPressed == flag) return;
    setState(() {
      isPerfomnceButtonPressed = flag;
    });
  }
}
