import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class CustomSnackBar {
  static SnackBar successesSnackBar(String message) {
    return SnackBar(
      content: Text(message,style: AppFont.textFieldLabel,),
      backgroundColor: AppColors.secondaryColor,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
  static SnackBar errorSnackBar(String message) {
    return SnackBar(
      content: Text(message,style: AppFont.errorText,),
      backgroundColor: AppColors.backgroundColors,
      behavior: SnackBarBehavior.floating,
      duration: Duration(seconds: 3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
