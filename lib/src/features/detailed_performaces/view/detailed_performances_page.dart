import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/theme/ui/skeleton_loaders.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/images_location.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/onboarding_welcome_args.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/features/view_images/models/image_view_args.dart';
import 'package:shebalin/src/features/view_images/view/images_view_page.dart';
import 'package:shebalin/src/models/payment_model.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/audio_demo.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/author_card.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/ui/app_placeholer.dart';
import 'package:url_launcher/url_launcher.dart';

class PerfomanceDescriptionScreen extends StatefulWidget {
  const PerfomanceDescriptionScreen({Key? key, required this.performance})
      : super(key: key);
  final Performance performance;
  static const routeName = '/perfomance-description-screen';

  @override
  State<PerfomanceDescriptionScreen> createState() =>
      _PerfomanceDescriptionScreenState();
}

class _PerfomanceDescriptionScreenState
    extends State<PerfomanceDescriptionScreen> {
  bool isBought = false;
  final paymentService = Payment();
  double top = 0.0;
  bool _isExpanded = true;
  bool _isCollapsed = false;
  late final ScrollController _controller = ScrollController()
    ..addListener(() {
      setState(() {
        _textColor = _isExpanded ? AppColor.whiteText : AppColor.blackText;
      });
    });
  Color _textColor = AppColor.whiteText;

  @override
  void initState() {
    _isExpanded =
        _controller.hasClients && _controller.offset <= (kToolbarHeight);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    _isExpanded =
        _controller.hasClients && _controller.offset <= (kToolbarHeight) * 3;
    return Scaffold(
      body: BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
          bool isLoading = state is PerformanceFullInfoLoadInProgress;
          return CustomScrollView(
            physics: isLoading ? const NeverScrollableScrollPhysics() : null,
            controller: _controller,
            scrollDirection: Axis.vertical,
            slivers: [
              SliverAppBar(
                elevation: 0.7,
                backgroundColor: AppColor.whiteBackground,
                expandedHeight: MediaQuery.of(context).size.height * 0.32,
                floating: false,
                pinned: true,
                flexibleSpace: isLoading
                    ? FlexibleSpaceBar(
                        background: Container(color: AppColor.greySkeleton),
                      )
                    : LayoutBuilder(
                        builder: (context, constraints) {
                          top = constraints.biggest.height;
                          top ==
                              MediaQuery.of(context).padding.top +
                                  kToolbarHeight;
                          return FlexibleSpaceBar(
                            centerTitle: !_isExpanded,
                            background: CachedNetworkImage(
                              imageUrl: widget.performance.imageLink,
                              fit: BoxFit.fill,
                              placeholder: (contxt, string) => const Center(
                                child: CircularProgressIndicator(
                                  color: AppColor.grey,
                                ),
                              ),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Text(
                                widget.performance.title,
                                style: _isExpanded
                                    ? Theme.of(context)
                                        .textTheme
                                        .displayMedium
                                        ?.copyWith(
                                          color: _textColor,
                                        )
                                    : Theme.of(context)
                                        .textTheme
                                        .headlineMedium
                                        ?.copyWith(
                                          color: _textColor,
                                        ),
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
                        color: _isExpanded
                            ? AppColor.grey
                            : AppColor.whiteBackground,
                      ),
                      child: Center(
                        child: IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: Image.asset(
                            ImagesSources.closePerformance,
                            color: _isExpanded
                                ? AppColor.whiteText
                                : AppColor.blackText,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<PerformanceBloc, PerformanceState>(
                builder: (context, state) {
                  return SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Image.asset(ImagesSources.timeGrey),
                              ),
                              isLoading
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.greySkeleton,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.18,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    )
                                  : Text(
                                      durationToHoursMinutes(
                                        state.perfomances[widget.performance.id]
                                            .info.duration,
                                      ).toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColor.greyText),
                                    )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 4),
                                child: Image.asset(ImagesSources.location),
                              ),
                              isLoading ||
                                      state.perfomances[widget.performance.id]
                                          .info.chapters.isEmpty
                                  ? Container(
                                      decoration: BoxDecoration(
                                        color: AppColor.greySkeleton,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      width: MediaQuery.of(context).size.width *
                                          0.27,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                    )
                                  : Text(
                                      state.perfomances[widget.performance.id]
                                          .info.chapters[0].place.address,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(color: AppColor.greyText),
                                    ),
                            ],
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          isLoading
                              ? const DescriptionSkeleton()
                              : Text(
                                  state.perfomances[widget.performance.id].info
                                      .description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12, bottom: 32),
                            child: isLoading
                                ? Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    decoration: BoxDecoration(
                                      color: AppColor.greySkeleton,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                  )
                                : CachedNetworkImage(
                                    imageBuilder: (context, imageProvider) =>
                                        Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                    height: MediaQuery.of(context).size.height *
                                        0.25,
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    imageUrl:
                                        "https://sun9-39.userapi.com/impg/wvR1_YIXqeP3hgZUUELQ5U3bvq1kEvKgvRbycA/f8n1n84CfzQ.jpg?size=343x200&quality=95&sign=99b10e66c024f3b0f08b823e49b1e412&type=album",
                                    fit: BoxFit.cover,
                                    placeholder: (contxt, string) =>
                                        const Center(
                                      child: AppProgressBar(),
                                    ),
                                  ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Text(
                                  "Аудио отрывки",
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                              ),
                              Column(
                                children: [
                                  const Divider(height: 1, thickness: 1),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.2,
                                    child: isLoading
                                        ? const AudioDemoSkeleton()
                                        : ListView.builder(
                                            itemCount: widget.performance.info
                                                .chapters.length,
                                            scrollDirection: Axis.vertical,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return state
                                                      is PerformanceLoadInProgress
                                                  ? const AppProgressBar()
                                                  : AudioDemo(
                                                      isBought: isBought,
                                                      performance:
                                                          state.perfomances[
                                                              widget.performance
                                                                  .id],
                                                      index: index,
                                                    );
                                            },
                                          ),
                                  ),
                                  const Divider(height: 1, thickness: 1)
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, bottom: 12),
                                child: Text(
                                  'Фотографии',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              isLoading
                                  ? PhotosSkeleton(
                                      photoHeight:
                                          MediaQuery.of(context).size.height *
                                              0.14,
                                      photoWidth:
                                          MediaQuery.of(context).size.width *
                                              0.32,
                                    )
                                  : ImagesLocation(
                                      imageLinks: state
                                          .perfomances[widget.performance.id]
                                          .info
                                          .images,
                                      onTap: _onImageTap,
                                    )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 32, bottom: 20),
                                child: Text(
                                  'Авторы',
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(fontWeight: FontWeight.w700),
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: ListView.builder(
                                  itemCount:
                                      widget.performance.info.creators.length,
                                  scrollDirection: Axis.horizontal,
                                  cacheExtent: 1000,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return isLoading
                                        ? const AuthorsSkeleton()
                                        : AuthorCard(
                                            performance: widget.performance,
                                            index: index,
                                          );
                                  },
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: mediaQuerySize.width * 0.15,
                ),
              )
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<PerformanceBloc, PerformanceState>(
        builder: (context, state) {
          if (state is PerformanceLoadSuccess) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  routePrefixPerfMode + OnboardWelcome.routeName,
                  arguments: OnboardingWelcomeArgs(
                    performance: state.perfomances[widget.performance.id],
                  ),
                ),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(AppColor.purplePrimary),
                  elevation: MaterialStateProperty.all(5),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(
                    Size(
                      mediaQuerySize.width - 32,
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
            );
          }
          return const SizedBox();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Future<Object?> showInformationDialog(
    BuildContext context,
  ) async {
    return await showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: '',
      pageBuilder: (
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
      ) {
        final TextEditingController textEditingController =
            TextEditingController();
        return Center(
          child: Container(
            decoration: const BoxDecoration(
              color: AppColor.whiteBackground,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Card(
              color: AppColor.whiteBackground,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 20,
                    ),
                    child: TextField(
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: AppColor.blackText,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                      cursorColor: AppColor.purplePrimary,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.grey),
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: AppColor.purplePrimary),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        hintText: 'Введите вашу почту',
                        alignLabelWithHint: true,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: AppColor.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.purplePrimary),
                      elevation: MaterialStateProperty.all(5),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      minimumSize:
                          MaterialStateProperty.all(const Size(200, 40)),
                    ),
                    onPressed: () {
                      _getPaymentLink(textEditingController.text);
                    },
                    child: Text(
                      'Отправить',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: AppColor.whiteText, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _getPaymentLink(email) async {
    final response = await paymentService.getLink(email, 'shebalin', '1');
    final Uri uri = Uri.parse(response.body, 1, response.body.length);
    await launchUrl(
      uri,
      mode: Platform.isIOS
          ? LaunchMode.platformDefault
          : LaunchMode.externalApplication,
    );
    _buyButton();
  }

  void _buyButton() {
    setState(() {
      isBought = true;
    });
  }

  void _onImageTap(List<String> imageLinks, int index) {
    Navigator.of(context).pushNamed(
      ImagesViewPage.routeName,
      arguments: ImageViewArgs(imageLinks, index),
    );
  }

  String durationToHoursMinutes(Duration duration) {
    final int hours = duration.inHours;
    final int minutes = duration.inMinutes - hours * 60;
    return '$hours ч. $minutes мин.';
  }
}
