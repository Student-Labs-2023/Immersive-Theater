// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shebalin/src/theme/app_color.dart';
import 'package:shebalin/src/theme/images.dart';

class AppBarBtnClose extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onPressed;
  const AppBarBtnClose({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: Image.asset(
          ImagesSources.closePerformance,
          color: AppColor.blackText,
        ),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
