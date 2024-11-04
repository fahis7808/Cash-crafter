import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../Model/account_model/transaction_model.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_font.dart';
import 'custom_card.dart';

class TransactionCard extends StatelessWidget {
  final List<TransactionModel> data;
  final String? accountName;
   const TransactionCard({Key? key, required this.data,  this.accountName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String formatDateString(String dateString) {
      if (dateString != "") {
        DateFormat inputFormat = DateFormat('dd-MM-yyyy');
        DateTime date = inputFormat.parse(dateString);
        DateFormat outputFormat = DateFormat('dd MMM yy');
        return outputFormat.format(date);
      } else {
        return "";
      }
    }
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: ((context, index) {
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
                      data[index].category.toString(),
                      style: AppFont.textFieldLabel,
                    ),
                    Text(
                     accountName ?? data[index].debit?.toString() ??
                          data[index].credit?.toString() ?? "",
                      style: AppFont.cardSubTitle,
                    )
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "\u{20B9} ${data[index].amount}",
                      style: const TextStyle(
                          fontSize: 20,
                          color: AppColors.positiveColor,
                          fontWeight: FontWeight.w800),
                    ),
                    Text(
                      formatDateString(data[index].date.toString()),
                      style: AppFont.cardSubTitle,
                    )
                  ],
                )
              ],
            )),
          );
        }));
  }
}
