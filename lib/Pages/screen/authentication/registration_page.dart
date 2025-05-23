import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/screen/home_screen/home_page.dart';
import 'package:cash_crafter/Pages/widget/button/button.dart';
import 'package:cash_crafter/provider/authentication_provider.dart';
import 'package:cash_crafter/util/snack_bar.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import '../../widget/text_field/custom_text_field.dart';
import 'google_fb_buttons.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool _showPassword = true;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    // Detect if the keyboard is visible

    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: Consumer<AuthenticationProvider>(builder: (context, data, _) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Center(
              child: ListView(
                children: [
                  const SizedBox(height: 60),
                  Text(
                    "Register to get started",
                    textAlign: TextAlign.center,
                    style: AppFont.head,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextField(
                          value: data.user.username,
                          labelText: "Name",
                          onChanged: (val) {
                            data.user.username = val;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          value: data.user.email,
                          labelText: "Email",
                          onChanged: (val) {
                            data.user.email = val;
                          },
                        ),
                        const SizedBox(height: 10),
                        CustomTextField(
                          isPassWord: _showPassword,
                          suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            child: Icon(
                              _showPassword ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                          value: data.password,
                          labelText: "Password",
                          onChanged: (val) {
                            setState(() {
                              data.password = val;
                            });
                          },
                        ),
                        if (data.password != null && data.password!.length < 6)
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              "Password must be more than 6",
                              style: AppFont.errorText,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    loading: _loading,
                    buttonText: "Sign in",
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      await data.handleSignUp().then((value) {
                        setState(() {
                          _loading = false;
                        });
                        if (value == "Signed Up") {
                          final snackBar = CustomSnackBar.successesSnackBar(
                              "Sign-up complete! Let’s get started.");
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        } else {
                          final snackBar = CustomSnackBar.errorSnackBar(value);
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  const GoogleFBButton(),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account? ",
                        style: AppFont.cardTitle,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                ],
              )
            ),
          ),
        );
      }),
    );
  }

}
