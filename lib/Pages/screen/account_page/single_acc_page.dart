import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Pages/widget/custom_widget/balance_showing_widget.dart';
import 'package:money_manage_app2/constant/app_colors.dart';
import 'package:money_manage_app2/constant/app_font.dart';

class SingleAccountPage extends StatelessWidget {
  const SingleAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        },icon: Icon(CupertinoIcons.back,color: AppColors.white,)),
        backgroundColor: AppColors.primaryColor,
        title: Text("Wallet", style: AppFont.subCardMainText,),
      ),
      body: Column(
        children: [
          MainBalance(amount: 1243)
        ],
      ),
    );
  }
}
