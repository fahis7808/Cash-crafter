import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/home_screen/home_page.dart';
import 'package:money_manage_app2/Pages/widget/button/button.dart';
import 'package:money_manage_app2/Pages/widget/text_field/custom_text_field.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomTextField(
              value: "",
              labelText: "Name",
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextField(
              value: "",
              labelText: "Number",
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextField(
              value: "",
              labelText: "E-mail",
            ),
            const SizedBox(
              height: 20,
            ),
            const CustomTextField(
              value: "",
              labelText: "Job",
            ),
            const SizedBox(
              height: 40,
            ),
            CustomButton(
                buttonText: "Continue",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  HomePage()));
                })
          ],
        ),
      ),
    );
  }
}
