import 'package:flutter/material.dart';
import 'package:cash_crafter/Pages/widget/button/next_button.dart';
import 'package:cash_crafter/Pages/widget/text_field/amount_text_field.dart';
import 'package:cash_crafter/constant/app_font.dart';
import 'package:cash_crafter/provider/balance_provider.dart';
import 'package:provider/provider.dart';

import '../../../util/snack_bar.dart';

class WalletInitialOpen extends StatelessWidget {
  const WalletInitialOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<BalanceProvider>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 15, 10, 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                "Amount in your wallet",
                style: AppFont.appBarHead,
              )),
          AmountTextField(
            value: provider.accModel.balance,
            onChange: (val) {
              provider.accModel.balance = double.tryParse(val) ?? 0;
            },
          ),
          const Spacer(),
          Align(
              alignment: Alignment.centerRight,
              child: NextButton(
                onTap: () {

                  provider.addBalance().then((value) {
                    if (value == true){
                      provider.onNextButton();
                      final snackBar = CustomSnackBar.successesSnackBar(
                        "Successfully opened Wallet",
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }else{
                      final snackBar = CustomSnackBar.errorSnackBar(
                        "Something went wrong",
                      );
                      ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    }
                  });
                },
              ))
        ],
      ),
    );
  }
}
