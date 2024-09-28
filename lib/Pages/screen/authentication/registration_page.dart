import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/home_screen/home_page.dart';
import 'package:money_manage_app2/Pages/widget/button/button.dart';
import 'package:money_manage_app2/provider/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import '../../widget/custom_text_field.dart';
import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}
bool _showPassword = true;

class _RegistrationPageState extends State<RegistrationPage> {
  @override
  Widget build(BuildContext context) {
    // final data = Provider.of<AuthenticationProvider>(context, listen: false);
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
                  "Register to get started",
                  textAlign: TextAlign.center,
                  style: AppFont.head,
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
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
                        isPassWord: _showPassword,
                        suffix: GestureDetector(
                          onTap: (){
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          child: Icon(_showPassword ? Icons.visibility_off : Icons.visibility),
                        ),
                        value: data.password,
                        labelText: "Password",
                        onChanged: (val) {
                          setState(() {
                          data.password = val;

                          });
                        },
                      ),
                      if(data.password != null  && data.password!.length < 6)
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text("Password must be more than 6",style: AppFont.errorText,),
                      )
                    ],
                  ),
                ),
                const Spacer(),
                CustomButton(
                  buttonText: "Sign in",
                  onPressed: () async {
                    final message = await data.handleSignUp();
                    if (message == "Signed Up") {
                      data.createUserToFireStore();
                      // ignore: use_build_context_synchronously
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
                    } else {
                      print("Error");
                    }
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
      }),
    );
  }
}
