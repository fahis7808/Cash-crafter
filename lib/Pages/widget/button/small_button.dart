import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class SmallButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  const SmallButton({super.key, this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: 15, vertical: 8),
        decoration: BoxDecoration(
            color: AppColors.secondaryColor,
            borderRadius:
            BorderRadius.circular(10)),
        child: Text(
          text,
          style: AppFont.white20,
        ),
      ),
    );
  }
}
