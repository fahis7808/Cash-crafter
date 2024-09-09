import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/authentication/otp_page.dart';
import 'package:money_manage_app2/Pages/widget/button.dart';
import 'package:money_manage_app2/Pages/widget/custom_text_field.dart';

class MobileNumberPage extends StatelessWidget {
  const MobileNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              children: [
                SizedBox(width: 60,child: CustomTextField(value: ""),),
                SizedBox(width: 10,),
                Expanded(
                  child: CustomTextField(
                    value: "",
                    // text: "Mobile Number",
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            CustomButton(
              buttonText: "Verify",
              onPressed: () => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => const OTPPage())),
            )
          ],
        ),
      ),
    );
  }
}
