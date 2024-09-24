import 'package:flutter/material.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class CustomCard extends StatelessWidget {
  final Color? color1;
  final Color? color2;
  final Widget child;
  final EdgeInsets? padding;

  const CustomCard(
      {Key? key, this.color1, this.color2, required this.child, this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: color1 != null && color2 != null
              ? LinearGradient(colors: [
                  color1 ?? const Color(0x24EAEAEA),
                  color2 ?? const Color(0x800A015D)
                ], begin: Alignment.topLeft, end: const Alignment(1.0, 1.0))
              : null,
          color: color2 == null ? color1 ?? AppColors.containerColor : null,
          borderRadius: const BorderRadius.all(
            Radius.circular(
              10,
            ),
          ),
        ),
        padding:
            padding ?? const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: child);
  }
}

class IncomeExpenseCard extends StatelessWidget {
  final bool income;
  final double amount;

  const IncomeExpenseCard({Key? key, required this.amount, this.income = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        // Center content vertically
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 25,
                height: 25,
                decoration: BoxDecoration(
                    color: income
                        ? AppColors.positiveColor
                        : AppColors.negativeColor,
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                child: Transform.rotate(
                  angle: income ? 1.6 : 0,
                  child: const Icon(
                    Icons.arrow_outward,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              const Row(
                children: [
                  Text(
                    "+10%",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: AppColors.positiveColor),
                  ),
                ],
              )
            ],
          ),
          const Spacer(),
          Text(
            income ? "Income" : "Spending",
            style: AppFont.cardTitle,
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            FormattedText.formattedAmount(amount),
            textAlign: TextAlign.center,
            style: AppFont.buttonText,
          ),
        ],
      ),
    );
  }
}
