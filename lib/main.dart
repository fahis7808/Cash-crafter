import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'Pages/screen/authentication/mobile_number.dart';

void main() async{
  await Hive.initFlutter();
  await Hive.openBox('cash');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: AppColors.primaryColor
      ),
      home: const MobileNumberPage(),
    );
  }
}
