import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shebalin/src/features/performances/bloc/performance_bloc.dart';
import 'package:shebalin/src/theme/theme.dart';

class AudioInfoWidget extends StatelessWidget {
  const AudioInfoWidget({super.key});

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
            imageUrl: ApiClient.baseUrl +
                "/uploads/1650699780132_bce6f77d48.jpg?updated_at=2023-03-30T05:50:05.517Z",
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
              "Глава 1",
              style: Theme.of(context).textTheme.labelLarge?.copyWith(),
            ),
            Text(
              "Шебалин в Омске",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontSize: 12, color: secondaryTextColor),
            ),
          ],
        ),
      ],
    );
  }
}
