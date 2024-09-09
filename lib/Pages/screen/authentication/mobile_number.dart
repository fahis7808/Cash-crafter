import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button.dart';
import 'package:money_manage_app2/Pages/widget/custom_text_field.dart';

class MobileNumberPage extends StatelessWidget {
  const MobileNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomTextField(value: "",text: "Mobile Number",),
            SizedBox(height: 50,),
            CustomButton(buttonText: "Verify",)
          ],
        ),
      ),
    );
  }
}
