
import 'package:flutter/material.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import 'custom_card.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: CustomCard(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Monthly Salary",
                    style: AppFont.textFieldLabel,
                  ),
                  Text(
                    "Wallet",
                    style: AppFont.cardSubTitle,
                  )
                ],
              ),
              Column(
                children: [
                  const Text(
                    "\u{20B9} 25,000",
                    style: TextStyle(
                        fontSize: 20,
                        color: AppColors.positiveColor,
                        fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "24 Sep 24",
                    style: AppFont.cardSubTitle,
                  )
                ],
              )
            ],
          )),
    );
  }
}
