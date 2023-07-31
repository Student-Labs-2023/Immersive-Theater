import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/theme.dart';

class FulScreenImageLocation extends StatelessWidget {
  final String imagePath;
  const FulScreenImageLocation({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imagePath,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: accentTextColor,
        ),
      ),
    );
  }
}
