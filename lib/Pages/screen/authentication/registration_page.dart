import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import '../../widget/custom_text_field.dart';
import 'login_page.dart';

class RegistrationPage extends StatelessWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  CustomTextField(value: "", text: "Name"),
                  SizedBox(
                    height: 10,
                  ),CustomTextField(value: "", text: "Email"),
                  SizedBox(
                    height: 10,
                  ),
                  CustomTextField(value: "", text: "Password"),
                ],
              ),
            ),
            const Spacer(),
            CustomButton(
              buttonText: "Log in",
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const RegistrationPage())),
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
                Text("Already have an account? ", style: AppFont.cardTitle,),
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
}
