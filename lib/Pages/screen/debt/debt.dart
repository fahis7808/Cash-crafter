import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/screen/debt/on_dept_tap.dart';
import 'package:money_manage_app2/Pages/screen/debt/total_loan_card.dart';
import 'package:money_manage_app2/Pages/widget/custom_appbar.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/custom_card.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';
import 'package:money_manage_app2/provider/dept_provider.dart';
import 'package:provider/provider.dart';

class DebtPage extends StatelessWidget {
  final bool showBackBtn;
  const DebtPage({Key? key,  this.showBackBtn = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(showBackBtn: showBackBtn,title: "Debt Page"),
      body: ChangeNotifierProvider(
        create: (ctx) => DebtProvider(),
        child: Consumer<DebtProvider>(
          builder: (context,data,_) {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextAmount(text: "I Lend", amount: 4532),
                        TextAmount(text: "I Owe", amount: 6535),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const MainLoanCard(),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomCard(
                    onTap: (){
                      data.sendMessageToWhatsApp();
                      // data.sendMessageToWhatsApp1("918893288945","Demo Message");
                      // data.getDebtData();
                      // Navigator.push(context, MaterialPageRoute(builder: (ctx)=> OnDeptTap()));
                    },
                      circularRadius: 10,
                      color: AppColors.primaryColor,
                      child: Row(
                        children: [
                          CustomCard(
                              child: Text(
                            "AF",
                            style: AppFont.white20,
                          )),
                          const SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Aboobacker Fahis",
                                style: AppFont.textFieldLabel,
                              ),
                              Text(
                                "88932 88945",
                                style: AppFont.cardSubTitle,
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Column(
                            children: [
                              Text(
                                "-234",
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.negativeColor),
                              )
                            ],
                          )
                        ],
                      ))
                ],
              ),
            );
          }
        ),
      ),
    );
  }
}
