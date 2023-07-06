import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'widgets/tiktok_photo.dart';

class VerticalSlidningScreen extends StatelessWidget {
  const VerticalSlidningScreen({Key? key}) : super(key: key);
  static const routeName = '/vertical-sliding-screen';
  static dynamic performance;

  @override
  Widget build(BuildContext context) {
    performance = ModalRoute.of(context)?.settings.arguments;

    final List<Widget> imageSliders = performance.imagesList
        .asMap()
        .entries
        .map<Widget>(
          (entry) => TikTokPhoto(
            entry: entry,
          ),
        )
        .toList();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          margin: const EdgeInsets.only(left: 12, top: 20),
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
              ),
            ],
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(0.5),
          ),
          child: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 36),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: CarouselSlider(
          options: CarouselOptions(
            viewportFraction: 1,
            enlargeCenterPage: false,
            scrollDirection: Axis.vertical,
            autoPlay: false,
            enableInfiniteScroll: false,
          ),
          items: imageSliders,
        ),
      ),
    );
  }
}
