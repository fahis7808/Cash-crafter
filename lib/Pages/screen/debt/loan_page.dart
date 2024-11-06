import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/Pages/widget/graph/pie_chart.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/util/formated_text.dart';

class LoanPage extends StatelessWidget {
  const LoanPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Your Loan"),
      body: Column(

        children: [
          CustomCard(
            margin: EdgeInsets.symmetric(horizontal: 15),
            padding: EdgeInsets.symmetric(vertical: 8,horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Bike Loan",
                    style: AppFont.white20,
                  ),
                  Text(
                    FormattedText.formattedAmount(23423),
                    style: AppFont.text25,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 150,
                      height: 150,
                      child: PieChartSample2()),
                  Column(
                    children: [
                      labelWidget("Paid Loan", 45365, AppColors.tertiaryColor),
                      SizedBox(height: 10,),
                     labelWidget("Rust Sum", 23423, AppColors.primaryColor),
                    ],
                  )
                ],
              ),
              rowData("EMI Amount", FormattedText.formattedAmount(3423)),
              rowData("Upcoming Due Date", "05 Dec 24"),
              rowData("Loan Tenor", "11 Months"),
              rowData("Remaining Tenor", "8 Months"),
            ],
          ))
        ],
      ),
    );
  }
  Widget labelWidget(String text,double amount,Color color){
    return      Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCard(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.only(top: 5),
            color: color,
            child: SizedBox()),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(FormattedText.formattedAmount(amount),style: AppFont.textFieldLabel,),
            Text(text,style: AppFont.text16)],)
      ],
    );
  }

  Widget rowData(String left,String right){
    return   Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left,style: TextStyle(fontSize: 16,color: AppColors.white),),
          Text(right,style: AppFont.textFieldLabel)
        ],
      ),
    );
  }
}
