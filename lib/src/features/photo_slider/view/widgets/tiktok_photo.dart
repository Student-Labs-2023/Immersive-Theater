import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/images.dart';

import '../../../../theme/theme.dart';

class TikTokPhoto extends StatefulWidget {
  const TikTokPhoto({
    Key? key,
    this.entry,
  }) : super(key: key);
  final dynamic entry;

  @override
  State<TikTokPhoto> createState() => _TikTokPhotoState();
}

class _TikTokPhotoState extends State<TikTokPhoto> {
  bool isLiked = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: "https://sun9-75.userapi.com/impg/chHgeUUfz0nDw-kaO1Qox1frCAxTrJXvgGqidQ/ujRT_p0QAms.jpg?size=375x260&quality=96&sign=21982d2b7354644d80981116c2a4e273&type=album",//ApiClient.baseUrl + widget.entry.value,
          fit: BoxFit.cover,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(
              color: accentTextColor,
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(),
                  InkWell(
                    onTap: () => _onLikeButtonPressed(),
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 5,
                            blurRadius: 7,
                          ),
                        ],
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 241, 228, 224)
                            .withOpacity(0.5),
                      ),
                      child: Image(
                        image: AssetImage(
                          isLiked
                              ? ImagesSources.pressedLike
                              : ImagesSources.like,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(200, 0, 0, 0),
                    Color.fromARGB(0, 0, 0, 0),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Заголовок ${widget.entry}',
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Текст к фото',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          height: 1.5,
                        ),
                  )
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _onLikeButtonPressed() {
    setState(() {
      isLiked = !isLiked;
    });
  }
}
