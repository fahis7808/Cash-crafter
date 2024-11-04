import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/provider/balance_provider.dart';
import 'package:money_manage_app2/splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => BalanceProvider(),)
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.teal,
            scaffoldBackgroundColor: AppColors.primaryColor),
        home: const SplashScreenPage(),
      ),
    );
  }
}
