import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shebalin/src/features/audioplayer/model/audio_panel_state.dart';
import 'package:shebalin/src/theme/images.dart';

import '../../../../theme/theme.dart';

class AudioDemo extends StatefulWidget {
  final bool isBought;
  final dynamic performance;
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
                      imageUrl: "https://sun9-80.userapi.com/impg/0SkG5Uqx-sIhfgeKq_TxPMvBBkcsaJB-hrha0w/QrPfk-MLkk4.jpg?size=269x257&quality=95&sign=038872e654d930817650a57daf3411d8&type=album",//ApiClient.baseUrl +widget.performance.audioCoverImageLink,
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
