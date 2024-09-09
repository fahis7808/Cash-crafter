import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/button.dart';
import 'package:pinput/pinput.dart';

import '../../../constant/app_colors.dart';

class OTPPage extends StatelessWidget {
  const OTPPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Pinput(
                length: 6,
                showCursor: true,
                defaultPinTheme: PinTheme(
                    height: 60,
                    width: 55,
                    decoration: BoxDecoration(
                        color: AppColors.cardColor,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primaryColor)),
                    textStyle: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.secondaryColor)),
                onChanged: (val) {

                },
              ),
            ],
          ),
          SizedBox(height: 50,),

          CustomButton(
            buttonText: "Verify",
            onPressed: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => const OTPPage())),
          ),
          Spacer()
        ],
      ),
    );
  }
}
