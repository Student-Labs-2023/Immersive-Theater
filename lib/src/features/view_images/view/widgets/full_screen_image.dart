import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/ui/app_placeholer.dart';

class FulScreenImageLocation extends StatelessWidget {
  final String imagePath;
  const FulScreenImageLocation({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return InteractiveViewer(
      panEnabled: false,
      child: CachedNetworkImage(
        imageUrl: imagePath,
        placeholder: (context, url) => const AppProgressBar(),
      ),
    );
  }
}
