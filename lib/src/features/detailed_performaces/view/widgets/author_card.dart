import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:performances_repository/performances_repository.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({Key? key, required this.performance, required this.index})
      : super(key: key);
  final Performance performance;
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
                    imageUrl: performance.creators[index].imageLink,
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
                    performance.creators[index].fullName,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  Text(
                    performance.creators[index].role,
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
