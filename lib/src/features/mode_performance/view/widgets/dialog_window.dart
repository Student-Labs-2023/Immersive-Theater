import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';

class DialogWindow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String titleCancel;
  final String titleApprove;
  final void Function() onPressedCancel;
  final void Function() onPressedApprove;
  const DialogWindow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onPressedCancel,
    required this.titleApprove,
    required this.titleCancel,
    required this.onPressedApprove,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineMedium!,
      ),
      content: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(fontWeight: FontWeight.normal, color: AppColor.blackText),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: onPressedCancel,
          child: Text(
            titleCancel,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontWeight: FontWeight.normal),
          ),
        ),
        TextButton(
          onPressed: onPressedApprove,
          child: Text(
            titleApprove,
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                  color: const Color(0XFFFF4F4F),
                ),
          ),
        )
      ],
    );
  }
}
