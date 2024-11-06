import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';

class CustomBackButton extends StatelessWidget {
  final VoidCallback? onBackPressed;
  const CustomBackButton({Key? key, this.onBackPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  IconButton(
      onPressed: onBackPressed ?? () {
        Navigator.pop(context);
      },
      icon: const Icon(
        CupertinoIcons.back,
        color: AppColors.white,
      ),
    );
  }
}
