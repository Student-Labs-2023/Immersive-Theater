import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/locations/bloc/location_bloc.dart';
import 'package:shebalin/src/features/locations/view/location_description_panel_page.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/map/view/yandex_map_page.dart';
import 'package:shebalin/src/features/performances/view/performances_panel_page.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_screen.dart';
import 'package:shebalin/src/features/user/view/personal_panel_page.dart';
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
        defaultPanelState: PanelState.OPEN,
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
                      const SizedBox(
                        width: 24,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.12),
                          borderRadius: containerRadius,
                        ),
                        child: const SizedBox(
                          height: 3,
                          width: 50,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Padding(padding: EdgeInsets.only(left: 20)),
                      TextButton(
                        onPressed: () => _isPerformancePanelShowed(true),
                        child: Text(
                          "Спектакли",
                          style: isPerfomnceButtonPressed
                              ? Theme.of(context).textTheme.bodyMedium
                              : Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: secondaryTextColor),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      TextButton(
                        onPressed: () => _isPerformancePanelShowed(false),
                        child: Text(
                          "Для вас",
                          style: isPerfomnceButtonPressed
                              ? Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: secondaryTextColor)
                              : Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.07,
                      ),
                      IconButton(
                        onPressed: () => Navigator.of(context)
                            .pushNamed(PromocodeScreen.routeName),
                        icon: Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Image.asset(ImagesSources.promocodeIcon),
                        ),
                      )
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
                          width: 50,
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
                  : PersonalPanelPage();
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
              Future.delayed(const Duration(seconds: 1), () {
                panelController.open();
              });
              return isPerfomnceButtonPressed
                  ? const PerformancesPanelPage()
                  : PersonalPanelPage();
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
