import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/screen/debt/loan/loan_page.dart';

import '../../../../constant/app_colors.dart';
import '../../../../constant/app_font.dart';
import '../../../widget/custom_widget/custom_card.dart';

class MainLoanCard extends StatelessWidget {
  const MainLoanCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (ctx) => LoanPage()));
      },
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.only(left: 20, top: 5, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(text: TextSpan(
              text: "No.of EMI:",
              style: AppFont.cardSubTitle,
              // style: AppFont.cardTitle,
              children: [TextSpan(text: " 2", style: AppFont.textFieldLabel)])),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextAmount(
                  text: "Monthly EMI",
                  textStyle: AppFont.cardSubTitle,
                  amount: 23423),
              const SizedBox(
                  height: 50,
                  child: VerticalDivider(
                    color: AppColors.colour2,
                    thickness: 1,
                  )),
              TextAmount(
                  text: "Loan Amount",
                  textStyle: AppFont.cardSubTitle,
                  amount: 23423),
            ],
          )
        ],
      ),
    );
  }
}
