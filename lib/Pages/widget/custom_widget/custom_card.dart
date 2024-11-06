import 'package:flutter/material.dart';
import 'package:money_manage_app2/util/formated_text.dart';

import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';

class CustomCard extends StatelessWidget {
  final Color? color;
  final Widget child;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final void Function()? onTap;
  final double? circularRadius;

  const CustomCard(
      {Key? key,
      this.color,
      required this.child,
      this.padding,
      this.onTap,
      this.margin, this.circularRadius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.black,
      onTap: onTap,
      child: Container(
          margin: margin,
          decoration: BoxDecoration(
              gradient:color == null ? LinearGradient(
                  colors: [Color(0x660E3177), Color(0x8006031E)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter) : null,
              color: color,
              borderRadius:  BorderRadius.all(
                Radius.circular(
                 circularRadius ?? 20,
                ),
              ),
              border: Border.all(color: AppColors.cardColor)),
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: child),
    );
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
                    borderRadius: const BorderRadius.all(Radius.circular(8))),
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
          SizedBox(
            height: 15,
          ),
          TextAmount(text: income ? "Income" : "Spending", amount: amount)
        ],
      ),
    );
  }
}

class TextAmount extends StatelessWidget {
  final String text;
  final double amount;
  final TextStyle? textStyle;

  const TextAmount(
      {Key? key, required this.text, required this.amount, this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: textStyle ?? AppFont.cardTitle,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          FormattedText.formattedAmount(amount),
          textAlign: TextAlign.center,
          style: AppFont.buttonText,
        ),
      ],
    );
  }
}
