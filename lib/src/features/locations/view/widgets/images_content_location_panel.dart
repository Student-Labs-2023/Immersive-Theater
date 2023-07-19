import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:api_client/api_client.dart';

class ImagesContentLocationPanel extends StatelessWidget {
  const ImagesContentLocationPanel({super.key, required this.imageLinks});
  final List<String> imageLinks;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: MediaQuery.of(context).size.height * 0.17,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: imageLinks.length,
        itemBuilder: (BuildContext context, int index) {
          if (imageLinks.isEmpty) {
            return Text(
              'Тут могли бы быть фото локации',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: primaryTextColor,
                    fontWeight: FontWeight.w700,
                  ),
            );
          } else {
            return Container(
              margin: const EdgeInsets.only(right: 8, left: 8),
              height: MediaQuery.of(context).size.height * 0.17,
              width: MediaQuery.of(context).size.height * 0.17,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              child: CachedNetworkImage(
                placeholder: (context, string) =>
                    CircularProgressIndicator(color: AppColor.grey),
                imageUrl: ApiClient.baseUrl + imageLinks[index],
              ),
            );
          }
        },
      ),
    );
  }
}
