import 'package:flutter/material.dart';
import 'package:image2pdf/data/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  final List<Widget>? actions;

  const CustomAppBar({super.key, this.title = '', this.actions});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appColors.appLightColor,
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      actions: actions ?? [],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(50);
}
