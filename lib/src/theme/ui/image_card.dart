import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageCard extends StatelessWidget {
  final String imageUrl;
  const ImageCard({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CachedNetworkImage(
        imageUrl: "https://sun9-80.userapi.com/impg/0SkG5Uqx-sIhfgeKq_TxPMvBBkcsaJB-hrha0w/QrPfk-MLkk4.jpg?size=269x257&quality=95&sign=038872e654d930817650a57daf3411d8&type=album",//ApiClient.baseUrl + imageUrl,
        height: 90,
        width: 90,
        fit: BoxFit.cover,
      ),
    );
  }
}
