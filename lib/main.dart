import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'Pages/screen/authentication/login_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: AppColors.primaryColor),
      home: const LoginPage(),
    );
  }
}
