import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFont {
  static TextStyle textFieldLabel = const TextStyle(
      fontSize: 18, color: AppColors.white, fontWeight: FontWeight.w600);

  static TextStyle textFieldText = const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.white);
static TextStyle textFieldLabelText = const TextStyle(
      fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textColor);

  static TextStyle buttonText = const TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white);

  static TextStyle head = const TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 30,
    color: AppColors.white,
  );

  static TextStyle cardTitle = const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
  static TextStyle subCardMainText = const TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w700,
    color: Colors.white,
  );
  static TextStyle cardSubTitle = const TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );
  static TextStyle appBarHead = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: AppColors.textColor,
  );
  static TextStyle errorText = const TextStyle(
    fontSize: 15.0,
    fontWeight: FontWeight.w600,
    color: AppColors.negativeColor,
  );
  static TextStyle text25 = const TextStyle(
    fontSize: 25.0,
    fontWeight: FontWeight.w800,
    color: AppColors.white,
  );
}
