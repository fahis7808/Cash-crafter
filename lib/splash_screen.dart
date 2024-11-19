import 'dart:async';
import 'package:flutter/material.dart';
import '../../../Pages/screen/authentication/login_page.dart';
import '../../../constant/app_font.dart';
import '../../../service/secure_storage.dart';

import 'Pages/screen/first_page.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();

    Future<void> navigateBasedOnLoginStatus() async {
      String? dbValue = await LocalDB.readFromDB("LoginID");
      if (dbValue != null && dbValue.isNotEmpty) {
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const FirstPage()));
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        }
      }
    }

    Timer(const Duration(seconds: 3), () async {
      navigateBasedOnLoginStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "CashCrafter",
          style: AppFont.textFieldLabelText,
        ),
      ),
    );
  }
}
