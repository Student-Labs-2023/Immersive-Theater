import 'package:flutter/material.dart';

class AnimatedTitle extends StatelessWidget {
  const AnimatedTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      child: AppTitle(
        title: title,
        key: Key(title),
      ),
    );
  }
}

class AppTitle extends StatelessWidget {
  const AppTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      key: key,
      textAlign: TextAlign.center,
      title,
      style: Theme.of(context)
          .textTheme
          .displaySmall!
          .copyWith(fontWeight: FontWeight.w700),
    );
  }
}
