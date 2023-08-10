import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/audio/bloc/audio_manager_bloc.dart';
import 'package:shebalin/src/features/audio/view/audio_manager.dart';
import 'package:shebalin/src/features/detailed_performaces/bloc/detailed_performance_bloc.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/author_card.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/detailed_map.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/text_with_leading.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/app_icon_button.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome_args.dart';
import 'package:shebalin/src/features/view_images/models/image_view_args.dart';
import 'package:shebalin/src/features/view_images/view/images_view_page.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_placeholer.dart';
import 'package:shebalin/src/theme/ui/image_card.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class DetailedPerformancePage extends StatefulWidget {
  const DetailedPerformancePage({super.key});
  static const routeName = '/detailed-performance';
  @override
  State<DetailedPerformancePage> createState() =>
      _DetailedPerformancePageState();
}

class _DetailedPerformancePageState extends State<DetailedPerformancePage> {
  final AudioManagerBloc audioManagerBloc = AudioManagerBloc();
  double top = 0.0;
  late final ScrollController _controller = ScrollController();
  bool get _isExpended =>
      _controller.hasClients && _controller.offset <= (kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailedPerformanceBloc, DetailedPerformanceState>(
        buildWhen: (previous, current) {
          return previous is DetailedPerformanceLoadInProgress;
        },
        builder: (context, state) {
          if (state is DetailedPerformanceLoadInProgress) {
            return const AppProgressBar();
          } else if (state is DetailedPerformanceUnPaid ||
              state is DetailedPerformanceDownLoaded ||
              state is DetailedPerformancePaid) {
            return CustomScrollView(
              controller: _controller,
              slivers: [
                SliverAppBar(
                  elevation: 0.7,
                  backgroundColor: AppColor.whiteBackground,
                  expandedHeight: MediaQuery.of(context).size.height * 0.32,
                  floating: false,
                  pinned: true,
                  flexibleSpace: LayoutBuilder(
                    builder: (context, constraints) {
                      top = constraints.biggest.height;
                      top ==
                          MediaQuery.of(context).padding.top + kToolbarHeight;
                      return FlexibleSpaceBar(
                        centerTitle: !_isExpended,
                        titlePadding:
                            const EdgeInsets.only(left: 16, bottom: 12),
                        background: CachedNetworkImage(
                          imageUrl: state.performance.imageLink,
                          fit: BoxFit.fill,
                          placeholder: (contxt, string) =>
                              const AppProgressBar(),
                        ),
                        title: Text(
                          state.performance.title,
                          overflow: TextOverflow.fade,
                          style: _isExpended
                              ? Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color: AppColor.whiteText,
                                  )
                              : Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: AppColor.blackText,
                                  ),
                        ),
                      );
                    },
                  ),
                  leading: Row(
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _isExpended
                              ? AppColor.grey
                              : AppColor.whiteBackground,
                        ),
                        child: Center(
                          child: IconButton(
                            onPressed: () {
                              audioManagerBloc
                                  .add(const AudioManagerAudioCompleted());
                              Navigator.of(context).pop();
                            },
                            icon: Image.asset(
                              ImagesSources.closePerformance,
                              color: _isExpended
                                  ? AppColor.whiteText
                                  : AppColor.blackText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              TextWithLeading(
                                title: durationToHoursMinutes(
                                  state.performance.info.duration,
                                ).toString(),
                                leading: ImagesSources.timeGrey,
                              ),
                              TextWithLeading(
                                title: state
                                    .performance.info.chapters[0].place.address,
                                leading: ImagesSources.location,
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Text(
                                state.performance.info.description,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16.0),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.25,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: DetailedMap(
                                initialCoords: Point(
                                  latitude: state.performance.info.chapters[0]
                                      .place.latitude,
                                  longitude: state.performance.info.chapters[0]
                                      .place.longitude,
                                ),
                                places: state.performance.info.chapters
                                    .map((e) => e.place)
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Header(
                          title: 'Аудио отрывки',
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18 +
                              16 * 2,
                          child: AudioManager(
                            width: MediaQuery.of(context).size.width * 0.8,
                            subtitle: state.performance.title,
                            chapters: state.performance.info.chapters,
                            bloc: audioManagerBloc,
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Header(title: 'Фотографии'),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.12,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.performance.info.images.length,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                              width: 8,
                            ),
                            itemBuilder: (context, index) => GestureDetector(
                              onTap: () => Navigator.of(context).pushNamed(
                                ImagesViewPage.routeName,
                                arguments: ImageViewArgs(
                                  state.performance.info.images,
                                  index,
                                ),
                              ),
                              child: ImageCard(
                                size: MediaQuery.of(context).size.height * 0.12,
                                imageUrl: state.performance.info.images[index],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Header(title: 'Авторы'),
                        const SizedBox(
                          height: 12,
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                          child: ListView.builder(
                            itemCount: state.performance.info.creators.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (BuildContext context, int index) {
                              return AuthorCard(
                                name: state
                                    .performance.info.creators[index].fullName,
                                role:
                                    state.performance.info.creators[index].role,
                                image: state
                                    .performance.info.creators[index].imageLink,
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.15,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            );
          }
          return const Text('error');
        },
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocBuilder<DetailedPerformanceBloc, DetailedPerformanceState>(
          builder: (context, state) {
            final DetailedPerformanceBloc bloc =
                context.read<DetailedPerformanceBloc>();
            final String? title;
            final VoidCallback? onTap;
            if (state is DetailedPerformanceLoadInProgress) {
              return const SizedBox.shrink();
            } else if (state is DetailedPerformanceUnPaid) {
              title = 'Приобрести за 299 ₽';
              onTap = () => {bloc.add(const DetailedPerformancePay())};
            } else if (state is DetailedPerformancePaid) {
              title = 'Загрузить спектакль';
              onTap = () => {bloc.add(const DetailedPerformanceDownload())};
            } else {
              title = 'Начать спектакль';
              onTap = () {
                audioManagerBloc.add(const AudioManagerAudioCompleted());
                Navigator.of(context).pushNamed(
                  routePrefixPerfMode + OnboardWelcome.routeName,
                  arguments: OnboardingWelcomeArgs(
                    performance: state.performance,
                  ),
                );
              };
            }

            return AppButton.primaryButton(
              title: title,
              onTap: onTap,
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  String durationToHoursMinutes(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes - hours * 60;
    return '$hours ч. $minutes мин.';
  }
}

class Header extends StatelessWidget {
  final String title;
  const Header({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .displaySmall
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
