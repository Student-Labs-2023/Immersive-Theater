import 'dart:io';

import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/models/payment_model.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/audio_demo.dart';
import 'package:shebalin/src/features/detailed_performaces/view/widgets/author_card.dart';
import 'package:shebalin/src/features/photo_slider/view/vertical_sliding_screen.dart';
import 'package:shebalin/src/theme/images.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import 'widgets/photo_card.dart';

class PerfomanceDescriptionScreen extends StatefulWidget {
  const PerfomanceDescriptionScreen({Key? key, this.performance})
      : super(key: key);
  final dynamic performance;
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

  @override
  Widget build(BuildContext context) {
    var mediaQuerySize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.27,
        ),
        child: AppBar(
          backgroundColor: accentTextColor,
          elevation: 0,
          flexibleSpace: CachedNetworkImage(
            imageUrl: ApiClient.baseUrl + widget.performance.coverImageLink,
            fit: BoxFit.fill,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
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
                    onPressed: () {},
                    icon: Image.asset(ImagesSources.annotationIcon),
                  ),
                ),
              ),
            ],
          ),
          actions: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.5),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Image(
                    image: AssetImage(ImagesSources.closeIcon),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 0),
            child: Container(
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.performance.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
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
                        onPressed: () => _changeStatus(),
                        icon: isFavoriteLocation
                            ? Image.asset(ImagesSources.favoriteIconOutlined)
                            : Image.asset(ImagesSources.favoriteIcon),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: secondaryTextColor, width: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 16, left: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.performance.duration,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          'Длительность',
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    color: secondaryTextColor,
                                    fontSize: 12,
                                  ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                widget.performance.description,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 14),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(
                isBought ? 'Аудио' : 'Аудио отрывок',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: isBought
                  ? Column(
                      children: [
                        const Divider(height: 1, thickness: 1),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.2,
                          child: ListView.builder(
                            itemCount: widget.performance.audioLinks.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int index) {
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Text(
                'Авторы',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontSize: 24, fontWeight: FontWeight.w800),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: SizedBox(
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
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Фотографии',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pushNamed(
                      VerticalSlidningScreen.routeName,
                      arguments: widget.performance,
                    ),
                    child: Text(
                      'Все',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: accentTextColor),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                  itemCount: widget.performance.imagesList.length,
                  scrollDirection: Axis.horizontal,
                  cacheExtent: 1000,
                  itemBuilder: (BuildContext context, int index) {
                    return PhotoCard(
                      performance: widget.performance,
                      index: index,
                    );
                  },
                ),
              ),
            ),
          ],
        ),
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
                    .bodySmall
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
