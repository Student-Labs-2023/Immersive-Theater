import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/features/detailed_performaces/view/performance_double_screen.dart';
import 'package:shebalin/src/theme/theme.dart';

class PerformanceCard extends StatelessWidget {
  const PerformanceCard({Key? key, required this.performance})
      : super(key: key);
  final dynamic performance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: InkWell(
        onTap: () => Navigator.of(context).pushNamed(
          PerformanceDoubleScreen.routeName,
          arguments: performance,
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 28),
          padding: const EdgeInsets.only(top: 12, bottom: 4),
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16.0)),
            color: Color.fromARGB(255, 248, 249, 251),
            boxShadow: [
              BoxShadow(
                color: Color.fromARGB(255, 239, 240, 242),
                spreadRadius: 2,
                offset: Offset(0, 0),
              ),
            ],
          ),
          height: 214,
          width: 327,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                clipBehavior: Clip.antiAlias,
                height: 139,
                width: 303,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16.0)),
                  color: secondaryColor,
                ),
                child: CachedNetworkImage(
                  imageUrl: "https://sun9-80.userapi.com/impg/0SkG5Uqx-sIhfgeKq_TxPMvBBkcsaJB-hrha0w/QrPfk-MLkk4.jpg?size=269x257&quality=95&sign=038872e654d930817650a57daf3411d8&type=album",//ApiClient.baseUrl + performance.cardImageLink,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(
                      color: accentTextColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 16, 4),
                child: Text(
                  performance.tag,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 0, 16, 4),
                child: Text(
                  performance.title,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
