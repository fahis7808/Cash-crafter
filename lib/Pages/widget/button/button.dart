import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final void Function() onPressed;
  final bool loading;

  const CustomButton(
      {Key? key,
      required this.buttonText,
      required this.onPressed,
      this.loading = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.secondaryColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
            child: loading
                ? const CircularProgressIndicator(color: AppColors.white,)
                : Text(
                    buttonText,
                    style: AppFont.buttonText,
                  )),
      ),
    );
  }
}
