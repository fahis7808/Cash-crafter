import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_font.dart';
import 'button/back_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool centerTitle;
  final List<Widget>? actions;
  final VoidCallback? onBackPressed;
  final bool showBackBtn;

  const CustomAppBar({super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
    this.onBackPressed,  this.showBackBtn = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading:showBackBtn ? CustomBackButton(
        onBackPressed: onBackPressed,
      ) : null,
      backgroundColor: AppColors.primaryColor,
      title: Text(
        title,
        style: AppFont.appBarHead,
      ),
      centerTitle: centerTitle,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
