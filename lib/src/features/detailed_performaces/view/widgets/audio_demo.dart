import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:performances_repository/performances_repository.dart';
import 'package:provider/provider.dart';
import 'package:shebalin/src/features/audioplayer/model/audio_panel_state.dart';
import 'package:shebalin/src/theme/images.dart';

import '../../../../theme/theme.dart';

class AudioDemo extends StatefulWidget {
  final bool isBought;
  final Performance performance;
  final int index;
  const AudioDemo({
    Key? key,
    required this.isBought,
    required this.performance,
    required this.index,
  }) : super(key: key);
  @override
  State<AudioDemo> createState() => _AudioDemoState();
}

class _AudioDemoState extends State<AudioDemo> {
  @override
  Widget build(BuildContext context) {
    final model = context.read<AudioPanelState>();
    return InkWell(
      onTap: () => model.openPanel(),
      child: Container(
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
                        child:
                            CircularProgressIndicator(color: accentTextColor),
                      ),
                      imageUrl:
                          ApiClient.baseUrl + widget.performance.imageLink,
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
                      widget.performance.fullInfo!.chapters[widget.index].title,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(),
                    ),
                    Text(
                      widget.performance.title,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: 12,
                            color: secondaryTextColor,
                          ),
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
      ),
    );
  }
}
