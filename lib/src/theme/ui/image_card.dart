import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/ui/app_placeholer.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  final double size;
  const ImageCard({
    super.key,
    required this.imageUrl,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        placeholder: (context, url) => const AppProgressBar(),
        imageUrl: imageUrl,
        height: size,
        width: size,
        fit: BoxFit.cover,
      ),
    );
  }
}
