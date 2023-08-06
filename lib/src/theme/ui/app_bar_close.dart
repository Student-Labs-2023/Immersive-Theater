// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shebalin/src/theme/app_color.dart';

class AppBarBtnClose extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  final String icon;
  const AppBarBtnClose({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          icon,
          color: AppColor.blackText,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
