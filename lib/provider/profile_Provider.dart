import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Model/user_model.dart';
import 'package:money_manage_app2/service/secure_storage.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel userData = UserModel();

  String? uid;

  ProfileProvider() {
    getLoginID();
    getData();
  }

  getLoginID() async {
    uid = await LocalDB.readFromDB("LoginID");
  }

  getData() async {
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (snapshot.exists) {
      userData = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    }
    notifyListeners();
  }

  updateData() async {
    try {
      await FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .update(userData.toMap());
    } catch (e) {
        print("error updating");
    }
  }

  onRefresh(){
    notifyListeners();
  }

}
