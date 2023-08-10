import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AuthorCard extends StatelessWidget {
  const AuthorCard({
    Key? key,
    required this.name,
    required this.role,
    required this.image,
  }) : super(key: key);
  final String name;
  final String role;
  final String image;
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
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
                  height: 64,
                  imageUrl: image,
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
                  name,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                Text(
                  role,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
