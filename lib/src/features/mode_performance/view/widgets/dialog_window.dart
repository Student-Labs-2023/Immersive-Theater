import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shebalin/src/theme/app_color.dart';
import 'dart:io' show Platform;

class DialogWindow extends StatelessWidget {
  final String title;
  final String subtitle;
  final String titlePrimary;
  final String titleSecondary;
  final void Function() onTapPrimary;
  final void Function() onTapSecondary;
  const DialogWindow({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTapPrimary,
    required this.titlePrimary,
    required this.titleSecondary,
    required this.onTapSecondary,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? CupertinoAlertDialog(
            title: Text(
              title,
              style: Theme.of(context).textTheme.headlineMedium!,
            ),
            content: Text(
              subtitle,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.normal, color: AppColor.blackText),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: onTapPrimary,
                child: Text(
                  titlePrimary,
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.normal),
                ),
              ),
              TextButton(
                onPressed: onTapSecondary,
                child: Text(
                  titleSecondary,
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: const Color(0XFFFF4F4F),
                      ),
                ),
              )
            ],
          )
        : AlertDialog(
            contentPadding: const EdgeInsets.fromLTRB(16, 20, 16, 10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: AppColor.greyText,
                      ),
                ),
                const SizedBox(
                  height: 22,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: AlertDialogButton(
                        isPrimary: true,
                        onTap: onTapPrimary,
                        title: titlePrimary,
                      ),
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: AlertDialogButton(
                        isPrimary: false,
                        onTap: onTapSecondary,
                        title: titleSecondary,
                      ),
                    )
                  ],
                )
              ],
            ),
          );
  }
}

class AlertDialogButton extends StatelessWidget {
  const AlertDialogButton({
    super.key,
    required this.onTap,
    required this.title,
    required this.isPrimary,
  });

  final void Function() onTap;
  final String title;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: const MaterialStatePropertyAll(0),
        overlayColor: const MaterialStatePropertyAll(
          AppColor.purpleLightPrimary,
        ),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        backgroundColor: MaterialStatePropertyAll(
          isPrimary ? AppColor.whiteBackground : AppColor.purplePrimary,
        ),
      ),
      onPressed: onTap,
      child: Text(
        title,
        style: isPrimary
            ? Theme.of(context).textTheme.bodyLarge
            : Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColor.whiteText,
                ),
      ),
    );
  }
}
