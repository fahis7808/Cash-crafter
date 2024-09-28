import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final void Function() onTap;
  const CustomFloatingActionButton({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      backgroundColor: Color(0xFF000759),
      child: const Icon(
        Icons.add_outlined,
        size: 32.0,
        color: AppColors.white,
      ),
    );
  }
}
