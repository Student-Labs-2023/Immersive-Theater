// ignore_for_file: require_trailing_commas

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/features/photo_slider/view/vertical_sliding_screen.dart';
import 'package:shebalin/src/theme/theme.dart';

class PhotoCard extends StatelessWidget {
  const PhotoCard({Key? key, required this.performance, required this.index})
      : super(key: key);
  final dynamic performance;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(VerticalSlidningScreen.routeName, arguments: performance),
      child: Container(
          width: 120,
          height: 120,
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
          ),
          margin: const EdgeInsets.only(right: 16),
          child: CachedNetworkImage(
            imageUrl: performance.imagesList[index],
            fit: BoxFit.cover,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(
                color: accentTextColor,
              ),
            ),
          )),
    );
  }
}
