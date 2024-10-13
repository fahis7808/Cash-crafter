import 'package:flutter/cupertino.dart';
import 'package:money_manage_app2/Pages/widget/button/next_button.dart';
import 'package:money_manage_app2/Pages/widget/text_field/amount_text_field.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class WalletInitialOpen extends StatelessWidget {
  const WalletInitialOpen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          const AmountTextField(value: 0),
          const Spacer(),
          const Align(alignment: Alignment.centerRight, child: NextButton())
        ],
      ),
    );
  }
}
