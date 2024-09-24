  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import '../../../constant/app_font.dart';

  class MainBalance extends StatelessWidget {
    final double amount;
    final String? text;
    const MainBalance({Key? key, required this.amount,  this.text}) : super(key: key);

    @override
    Widget build(BuildContext context) {
      final formattedAmount = NumberFormat('#,##0').format(amount);
      return  Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 20, bottom: 10),
            child: Text(
              "${text ?? ""}Balance",
              style: AppFont.cardSubTitle,
            ),
          ),
           Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text(
              "\u{20B9} $formattedAmount",
              style: const TextStyle(
                  fontSize: 35,
                  color: Colors.white,
                  fontWeight: FontWeight.w800),
            ),
          ),
        ],
      );
    }
  }
