import 'package:api_client/api_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shebalin/src/features/view_images/models/image_view_args.dart';
import 'package:shebalin/src/features/view_images/view/images_view_page.dart';
import 'package:shebalin/src/theme/ui/image_card.dart';

class ImagesLocation extends StatelessWidget {
  final List<String> imageLinks;
  const ImagesLocation({super.key, required this.imageLinks});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.09,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageLinks.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
            ImagesViewPage.routeName,
            arguments: ImageViewArgs(imageLinks, index),
          ),
          child: ImageCard(
            imageUrl: imageLinks[index],
          ),
        ),
      ),
    );
  }
}
