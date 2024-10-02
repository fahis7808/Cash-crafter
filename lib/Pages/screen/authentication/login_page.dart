import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/authentication/registration_page.dart';
import 'package:money_manage_app2/Pages/screen/home_screen/home_page.dart';
import 'package:money_manage_app2/Pages/widget/button/button.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
                    buttonText: "Log in",
                    onPressed: () async {
                      await data.login().then((value) {
                        if (value == "Signed In") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                        } else {
                          SnackBar(
                            content: Text(value),
                          );
                        }
                      });
                    }),
                const SizedBox(
                  height: 50,
                ),
                const Row(
                  children: [
                    GoogleFBCard(name: "Google"),
                    SizedBox(
                      width: 10,
                    ),
                    GoogleFBCard(name: "Facebook")
                  ],
                ),
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
                              color: AppColors.secondaryColor)),
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

class GoogleFBCard extends StatelessWidget {
  final String name;

  const GoogleFBCard({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.cardColor, width: 2)),
          child: Center(
              child: Text(
            name,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.w600),
          ))),
    );
  }
}
