import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/ui/image_card.dart';

class ImagesLocation extends StatelessWidget {
  final List<String> imageLinks;
  final void Function(List<String>, int) onTap;
  const ImagesLocation({
    super.key,
    required this.imageLinks,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.15,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: imageLinks.length,
        separatorBuilder: (context, index) => const SizedBox(
          width: 8,
        ),
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => onTap(imageLinks, index),
          child: ImageCard(
            imageUrl: imageLinks[index],
          ),
        ),
      ),
    );
  }
}
