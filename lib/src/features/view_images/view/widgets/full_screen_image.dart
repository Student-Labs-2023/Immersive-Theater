import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shebalin/src/theme/theme.dart';

class FulScreenImageLocation extends StatelessWidget {
  final String imagePath;
  const FulScreenImageLocation({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "https://sun9-80.userapi.com/impg/0SkG5Uqx-sIhfgeKq_TxPMvBBkcsaJB-hrha0w/QrPfk-MLkk4.jpg?size=269x257&quality=95&sign=038872e654d930817650a57daf3411d8&type=album",//ApiClient.baseUrl + imagePath,
      fit: BoxFit.cover,
      placeholder: (context, url) => Center(
        child: CircularProgressIndicator(
          color: accentTextColor,
        ),
      ),
    );
  }
}
