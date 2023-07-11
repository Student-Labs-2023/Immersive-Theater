import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int count;
  final bool isActive;
  const PageIndicator({super.key, required this.count, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 30),
      child: Container(
        height: 10,
        width: 10,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: isActive ? Colors.amber : Colors.grey,
        ),
      ),
    );
  }
}
