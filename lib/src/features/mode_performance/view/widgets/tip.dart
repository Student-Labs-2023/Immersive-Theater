import 'package:flutter/material.dart';

class Tip extends StatelessWidget {
  final String title;
  final String icon;
  final Color backgroundColor;
  const Tip({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      constraints: BoxConstraints(
        maxHeight: 100,
        maxWidth: MediaQuery.of(context).size.width - 30,
      ),
      child: Row(
        children: [
          ImageIcon(
            AssetImage(icon),
            size: 45,
          ),
          Flexible(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
