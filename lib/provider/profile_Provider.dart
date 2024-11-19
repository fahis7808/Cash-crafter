import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../Model/user_model.dart';
import '../../../service/secure_storage.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel userData = UserModel();

  String? uid;

  ProfileProvider() {
    getData();
  }

  Future<String> getLoginID() async {
    String uid = await LocalDB.readFromDB("LoginID");
    return uid.toString();
  }

  Future<String>getData() async {
    String uid = await getLoginID();
    try {
      DocumentSnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();

      if (snapshot.exists) {
        userData = UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
        notifyListeners();
        return "success";
      } else {
        return "no Data";
      }
    } catch (e) {
      print("Something went wrong");
      return "error";
    }
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

  onRefresh() {
    notifyListeners();
  }
}
