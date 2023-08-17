// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:locations_repository/locations_repository.dart';
// import 'package:shebalin/src/features/audioplayer/model/audio_panel_state.dart';
// import 'package:shebalin/src/features/locations/bloc/location_bloc.dart';
// import 'package:shebalin/src/features/mode_performance/view/performance_mode_page.dart';
// import 'package:shebalin/src/features/mode_performance/view/widgets/audio_player/audio_player.dart';
// import 'package:shebalin/src/features/onboarding_performance/view/onboarding_performance.dart';
// import 'package:shebalin/src/theme/theme.dart';
// import 'package:yandex_mapkit/yandex_mapkit.dart';

// class TicketPage extends StatefulWidget {
//   const TicketPage({super.key});
//   static const routeName = '/ticket-page';

//   @override
//   State<TicketPage> createState() => _TicketPageState();
// }

// class _TicketPageState extends State<TicketPage> {
//   late List<Location> locations;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<LocationBloc, LocationState>(
//         builder: (context, state) {
//           if (state is LocationsLoadSuccess) {
//             locations = state.locations;
//             return const Center(child: Text("Режим спектакля"));
//           } else {
//             return const CircularProgressIndicator();
//           }
//         },
//       ),
//       floatingActionButton: ElevatedButton(
//         onPressed: () {
//           _requestRoutes();
//         },
//         style: ButtonStyle(
//           backgroundColor: MaterialStateProperty.all(accentTextColor),
//           elevation: MaterialStateProperty.all(5),
//           shape: MaterialStateProperty.all(
//             RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           minimumSize: MaterialStateProperty.all(
//             Size(
//               MediaQuery.of(context).size.width * 0.85,
//               MediaQuery.of(context).size.width * 0.13,
//             ),
//           ),
//         ),
//         child: Text(
//           'Запустить спектакль',
//           style: Theme.of(context)
//               .textTheme
//               .bodySmall
//               ?.copyWith(color: Colors.white),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }

//   Future<void> _requestRoutes() async {
//     await Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (BuildContext context) => PerformanceModePage(
//           performanceTitle: "Шебалин в Омске",
//           imageLink:
//               "/uploads/1650699780207_58cb89ec46.jpg?updated_at=2023-03-30T05:51:54.127Z",
//         ),
//       ),
//     );
//   // }
// }
