import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Model/user_model.dart';
import 'package:money_manage_app2/service/secure_storage.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel userData = UserModel();

    String? uid;
    ProfileProvider(){
      getLoginID();
    }
    getLoginID()async{
      uid = await LocalDB.readFromDB("LoginID");
    }
  getData() async {
print(uid);
    QuerySnapshot data = await FirebaseFirestore.instance
        .collection("users")
        .where("uid", isEqualTo: uid)
        .get();

    print(data.metadata);
  }
}
