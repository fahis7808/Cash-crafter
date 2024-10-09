import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/authentication/google_fb_buttons.dart';
import 'package:money_manage_app2/Pages/screen/authentication/registration_page.dart';
import 'package:money_manage_app2/Pages/screen/home_screen/home_page.dart';
import 'package:money_manage_app2/Pages/widget/button/button.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

import '../../../util/snack_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

bool _showPassword = true;
bool _isLoading = false;

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: Consumer<AuthenticationProvider>(builder: (context, data, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                const Spacer(),
                Text(
                  "Welcome back!",
                  textAlign: TextAlign.center,
                  style: AppFont.head,
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      CustomTextField(
                        value: data.email,
                        labelText: "Email",
                        onChanged: (val) {
                          data.email = val;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        isPassWord: _showPassword,
                        suffix: GestureDetector(
                          onTap: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(_showPassword
                              ? Icons.visibility_off
                              : Icons.visibility),
                        ),
                        value: data.password,
                        labelText: "Password",
                        onChanged: (val) {
                          data.password = val;
                        },
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                CustomButton(
                    loading: _isLoading,
                    buttonText: "Log in",
                    onPressed: () async {
                      setState(() {
                        _isLoading = true;
                      });
                      await data.login().then((value) {
                        if (value == "Logged In") {
                          setState(() {
                            _isLoading = false;
                          });
                          final snackBar = CustomSnackBar.successesSnackBar(
                              "Login complete! Let’s get started.");
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          setState(() {
                            _isLoading = false;
                          });
                          final snackBar = CustomSnackBar.errorSnackBar(value);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    }),
                const SizedBox(
                  height: 50,
                ),
                const GoogleFBButton(),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: AppFont.cardTitle,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const RegistrationPage()));
                      },
                      child: const Text("Register Now",
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.tertiaryColor)),
                    )
                  ],
                ),
                const Spacer(),
              ],
            ),
          ),
        );
      }),
    );
  }
}
