import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              ? LinearGradient(
                  colors: [
                    color1 ?? const Color(0x24EAEAEA),
                    color2 ?? const Color(0x800A015D)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment(1.0, 1.0)
                )
              : null,
          color: color2 == null ? color1 : null,
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


class CardInnerChild extends StatelessWidget {
  final String head;
  final double amount;
  const CardInnerChild({Key? key, required this.head, required this.amount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      // Center content vertically
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              head,
              style: AppFont.cardTitle,
            ),
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(8))
              ),
              child: Icon(
                Icons.arrow_outward,
                color: Colors.white,
                size: 20,
              ),
            )
          ],
        ),
        const SizedBox(height: 5),
        Text(
          '\u{20B9} $amount',
          textAlign: TextAlign.center,
          style: AppFont.subCardMainText,
        ),
      ],
    );
  }
}
