import 'package:api_client/api_client.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({Key? key, this.performance, required this.index})
      : super(key: key);
  final dynamic performance;
  final int index;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 64,
          minWidth: 200,
          maxHeight: 64,
        ),
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12.0)),
            color: Color.fromARGB(255, 241, 243, 247),
          ),
          padding: const EdgeInsets.all(12),
          margin: const EdgeInsets.only(right: 12),
          child: Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: Colors.grey.shade100,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(50)),
                  child: CachedNetworkImage(
                    imageUrl: "https://sun9-80.userapi.com/impg/0SkG5Uqx-sIhfgeKq_TxPMvBBkcsaJB-hrha0w/QrPfk-MLkk4.jpg?size=269x257&quality=95&sign=038872e654d930817650a57daf3411d8&type=album",//ApiClient.baseUrl + performance.authorsImage[index],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    performance.authorsName[index],
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    performance.authorsRole[index],
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
