import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button.dart';
import 'package:money_manage_app2/provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import '../../widget/custom_text_field.dart';
import 'login_page.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final data = Provider.of<AuthenticationProvider>(context, listen: false);
    return ChangeNotifierProvider(
      create: (context) => AuthenticationProvider(),
      child: Consumer<AuthenticationProvider>(
        builder: (context,data,_) {
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
                    "Register to get started",
                    textAlign: TextAlign.center,
                    style: AppFont.head,
                  ),
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        CustomTextField(
                          value: data.user.username,
                          labelText: "Name",
                          onChanged: (val) {
                            data.user.username = val;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          value: data.user.email,
                          labelText: "Email",
                          onChanged: (val) {
                            data.user.email = val;
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          value: data.password,
                          labelText: "Password",
                          onChanged: (val) {
                            data.password = val;
                          },
                          // validator: (val){
                          //   if(val == null || val.isEmpty){
                          //
                          //   }
                          // },
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  CustomButton(
                    buttonText: "Sign in",
                    onPressed: (){

                    },
                  ),
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
                        "Already have an account? ",
                        style: AppFont.cardTitle,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Log in",
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
        }
      ),
    );
  }
}
