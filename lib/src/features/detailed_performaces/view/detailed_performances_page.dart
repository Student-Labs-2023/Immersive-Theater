import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:shebalin/src/models/payment_model.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/audio_demo.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/author_card.dart';
import 'package:shebalin/src/features/photo_slider/view/vertical_sliding_screen.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../photo_slider/view/widgets/tiktok_photo.dart';
import 'widgets/photo_card.dart';

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
  bool isFavoriteLocation = false;
  final paymentService = Payment();

  bool get _isExpanded =>
      _controller.hasClients && _controller.offset < (kToolbarHeight);
  late final ScrollController _controller = ScrollController()
    ..addListener(() {
      setState(() {
        _textColor = _isExpanded ? Colors.white : Colors.black;
      });
    });
  Color _textColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    final List<Widget> imageSliders = widget.performance.imagesList
        .map((e) => TikTokPhoto(
              entry: e,
            ))
        .toList();
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        scrollDirection: Axis.vertical,
        slivers: [
          SliverAppBar(
            backgroundColor: secondaryColor,
            expandedHeight: 260,
            floating: false,
            centerTitle: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              background: CachedNetworkImage(
                imageUrl:
                    "https://sun9-75.userapi.com/impg/chHgeUUfz0nDw-kaO1Qox1frCAxTrJXvgGqidQ/ujRT_p0QAms.jpg?size=375x260&quality=96&sign=21982d2b7354644d80981116c2a4e273&type=album", //ApiClient.baseUrl + widget.performance.coverImageLink,
                fit: BoxFit.fill,
                placeholder: (contxt, string) => const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
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
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Center(
                    child: IconButton(
                      color: _textColor,
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
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.timer,
                        size: 20,
                        color: secondaryTextColor,
                      ),
                      Text(
                        widget.performance.duration,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: secondaryTextColor, fontSize: 12),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        size: 20,
                        color: secondaryTextColor,
                      ),
                      Text(
                        widget.performance.tag,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(color: secondaryTextColor, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    widget.performance.description,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.fill)),
                    ),
                    height: 200,
                    width: 434,
                    imageUrl:
                        "https://sun9-75.userapi.com/impg/chHgeUUfz0nDw-kaO1Qox1frCAxTrJXvgGqidQ/ujRT_p0QAms.jpg?size=375x260&quality=96&sign=21982d2b7354644d80981116c2a4e273&type=album", //ApiClient.baseUrl + widget.performance.coverImageLink,
                    fit: BoxFit.cover,
                    placeholder: (contxt, string) => const Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Аудио отрывки",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 24, fontWeight: FontWeight.w800),
                      ),
                      isBought
                          ? Column(
                              children: [
                                const Divider(height: 1, thickness: 1),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.2,
                                  child: ListView.builder(
                                    itemCount:
                                        widget.performance.audioLinks.length,
                                    scrollDirection: Axis.vertical,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return AudioDemo(
                                        isBought: isBought,
                                        performance: widget.performance,
                                        index: index,
                                      );
                                    },
                                  ),
                                ),
                                const Divider(height: 1, thickness: 1)
                              ],
                            )
                          : AudioDemo(
                              isBought: isBought,
                              performance: widget.performance,
                              index: 0,
                            ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 12),
                        child: Text(
                          'Фотографии',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                      ),
                      CarouselSlider(
                        items: List.generate(
                          widget.performance.imagesList.length,
                          (index) => CachedNetworkImage(
                            imageBuilder: (context, imageProvider) => Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            height: 88,
                            width: 88,
                            imageUrl:
                                "https://sun9-75.userapi.com/impg/chHgeUUfz0nDw-kaO1Qox1frCAxTrJXvgGqidQ/ujRT_p0QAms.jpg?size=375x260&quality=96&sign=21982d2b7354644d80981116c2a4e273&type=album", //ApiClient.baseUrl + widget.performance.coverImageLink,
                            fit: BoxFit.fill,
                            placeholder: (contxt, string) => const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        options: CarouselOptions(
                          enableInfiniteScroll: true,
                          height: 88,
                          aspectRatio: 3.0,
                          viewportFraction: 0.3,
                        ),
                      ),
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
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                        child: ListView.builder(
                          itemCount: widget.performance.authorsName.length,
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
          ),
         SliverToBoxAdapter(
            child:  SizedBox(
              height: mediaQuerySize.width * 0.13 + 20,
            ),
          )
        ],
      ),
      floatingActionButton: isBought
          ? null
          : ElevatedButton(
              onPressed: () async {
                showInformationDialog(context);
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
                'Приобрести за 299 ₽',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: Colors.white),
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
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(18)),
            ),
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Card(
              color: Colors.white,
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
                            color: primaryTextColor,
                            fontSize: 20,
                            decoration: TextDecoration.none,
                          ),
                      cursorColor: accentTextColor,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: accentTextColor),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        hintText: 'Введите вашу почту',
                        alignLabelWithHint: true,
                        hintStyle: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(color: Colors.grey, fontSize: 20),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(accentTextColor),
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
                          ?.copyWith(color: Colors.white, fontSize: 18),
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

  void _changeStatus() {
    setState(() {
      isFavoriteLocation = !isFavoriteLocation;
    });
  }
}
