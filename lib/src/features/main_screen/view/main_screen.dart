import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/authentication/bloc/authentication_bloc.dart';
import 'package:shebalin/src/features/locations/view/location_description_panel_page.dart';
import 'package:shebalin/src/features/login/view/login_page.dart';
import 'package:shebalin/src/features/map/bloc/map_pin_bloc.dart';
import 'package:shebalin/src/features/map/view/yandex_map_page.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/features/performances/view/performances_panel_page.dart';
import 'package:shebalin/src/features/promocodes/view/widgets/promocode_panel_page.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

import 'package:shebalin/src/theme/theme.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final panelController = PanelController();
  bool isPerfomnceButtonPressed = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: IconButton(
        icon: const Icon(Icons.logout),
        onPressed: _logout,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: SlidingUpPanel(
        controller: panelController,
        defaultPanelState: PanelState.CLOSED,
        minHeight: MediaQuery.of(context).size.height * 0.12,
        maxHeight: MediaQuery.of(context).size.height * 0.85,
        header: BlocConsumer<MapPinBloc, MapPinState>(
          listener: (context, state) {},
          builder: (context, state) {
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
                          height: 4,
                          width: 32,
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Padding(padding: EdgeInsets.only(left: 20)),
                    SizedBox(
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
                    SizedBox(
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
          },
        ),
        panel: BlocListener<MapPinBloc, MapPinState>(
          listenWhen: (previous, current) => current is MapPinLoaded,
          listener: (context, state) {
            if (state is MapPinLoaded) {
              showBottomSheet(
                backgroundColor: AppColor.whiteBackground,
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.565,
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                context: context,
                builder: (context) {
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 20),
                      ),
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
                                height: 4,
                                width: 32,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.518,
                        child: LocationDescriptionPanelPage(
                          mapObjectId: state.mapObject.mapId.value,
                        ),
                      )
                    ],
                  );
                },
              );
            }
          },
          child: BlocConsumer<MapPinBloc, MapPinState>(
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
              } else if (state is MapPinClosingState) {
                return isPerfomnceButtonPressed
                    ? const PerformancesPanelPage()
                    : const PromocodePanelPage();
              }
              return isPerfomnceButtonPressed
                  ? const PerformancesPanelPage()
                  : const PromocodePanelPage();
            },
          ),
        ),
        body: Center(
          child: BlocBuilder<PerformanceBloc, PerformanceState>(
            builder: (context, state) {
              if (state is PerformanceLoadInProgress) {
                return const YandexMapPage(
                  mapObjects: [],
                );
              } else if (state is PerformanceLoadSuccess) {
                List<PlacemarkMapObject> placeMarks = [];

                for (var perf in state.perfomances) {
                  List<Place> places =
                      perf.info.chapters.map((e) => e.place).toList();
                  for (var i = 0; i < places.length; i++) {
                    placeMarks.add(
                      PlacemarkMapObject(
                        onTap: (mapObject, point) {
                          _mapPinTapped(
                            mapObject,
                            perf.info.chapters.length,
                            point,
                            context,
                          );
                        },
                        mapId: MapObjectId(
                          '${perf.id}/$i',
                        ),
                        opacity: 1,
                        point: Point(
                          latitude: places[i].latitude,
                          longitude: places[i].longitude,
                        ),
                        isDraggable: true,
                        icon: PlacemarkIcon.single(
                          PlacemarkIconStyle(
                            image: BitmapDescriptor.fromAssetImage(
                              ImagesSources.currentPlacemark,
                            ),
                            scale: 0.3,
                          ),
                        ),
                      ),
                    );
                  }
                }
                return YandexMapPage(
                  mapObjects: placeMarks,
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

  void _mapPinTapped(
    MapObject mapObject,
    int count,
    Point point,
    BuildContext context,
  ) {
    final String id = mapObject.mapId.value.toString();
    log(id);
    if (id.endsWith('0') && count == 1) {
      context.read<PerformanceBloc>().add(
            PerformanceLoadFullInfo(
              int.parse(id.substring(0, id.indexOf('/'))),
            ),
          );
    } else {
      context.read<MapPinBloc>().add(UpdateMapPinLocation(mapObject, point));
    }
  }

  void _logout() {
    context.read<AuthenticationBloc>().add(AuthenticationLogoutRequested());
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginPage.routeName,
      (Route<dynamic> route) => false,
    );
  }
}
