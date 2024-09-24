import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppFont {
  static TextStyle textFieldLabel = const TextStyle(
      fontSize: 18, color: AppColors.white, fontWeight: FontWeight.w600);

  static TextStyle textFieldText = const TextStyle(
      fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.primaryColor);

  static TextStyle buttonText = const TextStyle(
      fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.white);

  static TextStyle head = const TextStyle(
    fontWeight: FontWeight.w900,
    fontSize: 35,
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
    color: Color(0xFF8C95A6),
  );
  static TextStyle appBarHead = const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    color: Color(0xFF8C95A6),
  );
}
