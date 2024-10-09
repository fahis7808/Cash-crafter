import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/authentication/login_page.dart';
import 'package:money_manage_app2/Pages/screen/home_screen/home_page.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/service/secure_storage.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () async {
      String? dbValue = await LocalDB.readFromDB("LoginID");
      if (dbValue != null || dbValue!.isNotEmpty) {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const HomePage()));
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      }
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
