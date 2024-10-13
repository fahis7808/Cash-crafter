import 'package:flutter/cupertino.dart';
import 'package:money_manage_app2/Model/account_model/account_model.dart';
import 'package:money_manage_app2/Model/account_model/balance_model.dart';

class BalanceProvider extends ChangeNotifier{


  bool wallet = true;

  BalanceModel balanceModel = BalanceModel();

  AccountModel accModel = AccountModel();

  addAccount(){
    try{

    }catch(e){
      print(e);
    }
  }
}