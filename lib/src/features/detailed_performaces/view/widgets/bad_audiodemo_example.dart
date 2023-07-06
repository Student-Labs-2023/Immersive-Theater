import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/images.dart';

import '../../../../theme/theme.dart';

class BadAudioDemo extends StatefulWidget {
  final bool isBought;
  final dynamic performance;
  final int index;
  const BadAudioDemo({
    Key? key,
    required this.isBought,
    required this.performance,
    required this.index,
  }) : super(key: key);
  @override
  State<BadAudioDemo> createState() => _BadAudioDemoState();
}

class _BadAudioDemoState extends State<BadAudioDemo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey.shade100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  child: CachedNetworkImage(
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(color: accentTextColor),
                    ),
                    imageUrl: ApiClient.baseUrl +
                        widget.performance.audioCoverImageLink,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.performance.audioTitles[widget.index],
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                  ),
                  Text(
                    widget.performance.title,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 12, color: secondaryTextColor),
                  ),
                ],
              ),
            ],
          ),
          widget.isBought
              ? IconButton(
                  onPressed: () {},
                  icon: const Image(
                    image: AssetImage(ImagesSources.geoIcon),
                  ),
                )
              : Text('1:04', style: Theme.of(context).textTheme.titleSmall),
        ],
      ),
    );
  }
}
