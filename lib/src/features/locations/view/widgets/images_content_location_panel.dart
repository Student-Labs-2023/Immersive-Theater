import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/theme.dart';
import 'package:api_client/api_client.dart';

import '../../../view_images/models/image_view_args.dart';
import '../../../view_images/view/images_view_page.dart';

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
                margin: const EdgeInsets.only(
                  right: 8,
                ),
                height: MediaQuery.of(context).size.height * 0.17,
                width: MediaQuery.of(context).size.height * 0.17,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                    ImagesViewPage.routeName,
                    arguments: ImageViewArgs(imageLinks, index),
                  ),
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    height: 88,
                    width: 88,
                    imageUrl: ApiClient.baseUrl + imageLinks[index],
                    fit: BoxFit.fill,
                    placeholder: (contxt, string) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColor.whiteText,
                      ),
                    ),
                  ),
                ));
          }
        },
      ),
    );
  }
}
