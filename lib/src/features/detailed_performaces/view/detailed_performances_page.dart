import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/features/mode_performance/view/widgets/images_location.dart';
import 'package:shebalin/src/features/onboarding_performance/view/widgets/app_icon_button.dart';
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

  bool get _isExpanded =>
      _controller.hasClients && _controller.offset < (kToolbarHeight);
  late final ScrollController _controller = ScrollController()
    ..addListener(() {
      setState(() {
        _textColor = _isExpanded ? AppColor.whiteText : AppColor.blackText;
      });
    });
  Color _textColor = AppColor.whiteText;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            backgroundColor: AppColor.whiteBackground,
            expandedHeight: MediaQuery.of(context).size.height * 0.32,
            floating: false,
            centerTitle: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: CachedNetworkImage(
                imageUrl: widget.performance.imageLink,
                fit: BoxFit.fill,
                placeholder: (contxt, string) => const Center(
                  child: CircularProgressIndicator(
                    color: AppColor.grey,
                  ),
                ),
              ),
              title: Text(
                widget.performance.title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: _textColor),
              ),
            ),
            leading: Row(
              children: [
                const SizedBox(
                  width: 20,
                ),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isExpanded
                        ? AppColor.lightGray
                        : AppColor.whiteBackground,
                  ),
                  child: Center(
                    child: IconButton(
                      color: _isExpanded
                          ? AppColor.whiteBackground
                          : AppColor.grey,
                      onPressed: () => Navigator.of(context).pop(),
                      icon: Image.asset(
                        ImagesSources.closeIcon,
                        color: _textColor,
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.access_time_outlined,
                              size: 20,
                              color: AppColor.greyText,
                            ),
                          ),
                          state is PerformanceFullInfoLoadInProgress
                              ? const AppProgressBar()
                              : Text(
                                  durationToHoursMinutes(state
                                          .perfomances[widget.performance.id]
                                          .duration)
                                      .toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: AppColor.greyText),
                                )
                        ],
                      ),
                      Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 4),
                            child: Icon(
                              Icons.location_pin,
                              size: 20,
                              color: AppColor.greyText,
                            ),
                          ),
                          state is PerformanceFullInfoLoadInProgress ||
                                  state.perfomances[widget.performance.id]
                                      .chapters.isEmpty
                              ? const AppProgressBar()
                              : Text(
                                  state.perfomances[widget.performance.id]
                                      .chapters[0].place.address,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: AppColor.greyText),
                                )
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      state is PerformanceLoadInProgress
                          ? const AppProgressBar()
                          : Text(
                              state.perfomances[widget.performance.id]
                                  .description,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12, bottom: 32),
                        child: CachedNetworkImage(
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.9,
                          imageUrl:
                              "https://sun9-39.userapi.com/impg/wvR1_YIXqeP3hgZUUELQ5U3bvq1kEvKgvRbycA/f8n1n84CfzQ.jpg?size=343x200&quality=95&sign=99b10e66c024f3b0f08b823e49b1e412&type=album",
                          fit: BoxFit.cover,
                          placeholder: (contxt, string) => const Center(
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
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: ListView.builder(
                                  itemCount: widget.performance.chapters.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return AudioDemo(
                                      isBought: isBought,
                                      performance: state
                                          .perfomances[widget.performance.id],
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
                            padding: const EdgeInsets.only(top: 20, bottom: 12),
                            child: Text(
                              'Фотографии',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          state is PerformanceFullInfoLoadInProgress
                              ? const AppProgressBar()
                              : ImagesLocation(
                                  imageLinks: state
                                      .perfomances[widget.performance.id]
                                      .images,
                                  onTap: _onImageTap,
                                )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 32, bottom: 20),
                            child: Text(
                              'Авторы',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall
                                  ?.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1,
                            child: ListView.builder(
                              itemCount: widget.performance.creators.length,
                              scrollDirection: Axis.horizontal,
                              cacheExtent: 1000,
                              itemBuilder: (BuildContext context, int index) {
                                return AuthorCard(
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
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: isBought
            ? BlocBuilder<PerformanceBloc, PerformanceState>(
                builder: (context, state) {
                  return AppButton(
                    title: 'Начать спектакль',
                    onTap: () => Navigator.of(context).pushNamed(
                      routePrefixPerfMode + OnboardWelcome.routeName,
                      arguments: OnboardingWelcomeArgs(
                        performance: state.perfomances[widget.performance.id],
                      ),
                    ),
                    textColor: AppColor.whiteText,
                    backgroundColor: AppColor.purplePrimary,
                    borderColor: AppColor.purplePrimary,
                  );
                },
              )
            : AppButton(
                title: 'Приобрессти за 299 р',
                onTap: _buyButton,
                textColor: AppColor.whiteText,
                backgroundColor: AppColor.purplePrimary,
                borderColor: AppColor.purplePrimary,
              ),
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
