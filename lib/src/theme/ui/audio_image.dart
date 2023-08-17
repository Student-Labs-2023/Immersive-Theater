import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'app_placeholer.dart';

class AudioImage extends StatelessWidget {
  const AudioImage({
    super.key,
    required this.imageLink,
    required this.size,
  });
  final double size;
  final String imageLink;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        height: size,
        width: size,
        placeholder: (context, url) => const AppProgressBar(),
        imageUrl: imageLink,
        fit: BoxFit.cover,
      ),
    );
  }
}
