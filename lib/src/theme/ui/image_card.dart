import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/ui/app_placeholer.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  const ImageCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        placeholder: (context, url) => const AppProgressBar(),
        imageUrl: ApiClient.baseUrl + imageUrl,
        height: 90,
        width: 90,
        fit: BoxFit.cover,
      ),
    );
  }
}
