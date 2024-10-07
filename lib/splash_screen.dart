import 'dart:async';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/authentication/login_page.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({Key? key}) : super(key: key);

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage())));
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Center(
        child: Text("CashCrafter",style: AppFont.textFieldLabelText,),
      ),
    );
  }
}
