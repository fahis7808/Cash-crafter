import 'package:cash_crafter/constant/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../../../constant/app_colors.dart';
import '../../../splash_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiProvider(
      providers: provider,
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {

  @override
  void initState() {
_fetchPermission();
    super.initState();
  }

  Future<void> _fetchPermission() async {
     await FlutterContacts.requestPermission(readonly: true);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.teal,
          scaffoldBackgroundColor: AppColors.primaryColor),
      home: const SplashScreenPage(),
    );
  }
}
