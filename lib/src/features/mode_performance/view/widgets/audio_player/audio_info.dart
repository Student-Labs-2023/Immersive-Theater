import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/theme.dart';

class AudioInfoWidget extends StatelessWidget {
  final String performanceTitle;
  final String audioTitle;
  final String imageLink;
  const AudioInfoWidget({
    super.key,
    required this.performanceTitle,
    required this.audioTitle,
    required this.imageLink,
  });
// "/uploads/1650699780132_bce6f77d48.jpg?updated_at=2023-03-30T05:50:05.517Z"
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: CachedNetworkImage(
            height: 40,
            width: 40,
            placeholder: (context, url) => Center(
              child: CircularProgressIndicator(color: accentTextColor),
            ),
            imageUrl: ApiClient.baseUrl + imageLink,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              audioTitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: AppColor.purplePrimary),
            ),
            Text(
              performanceTitle,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 12,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
