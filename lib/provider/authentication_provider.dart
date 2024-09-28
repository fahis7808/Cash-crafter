import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:money_manage_app2/Model/user_model.dart';

class AuthenticationProvider extends ChangeNotifier {
  UserModel user = UserModel();
  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection("users");
  String? password;

  Future<String> handleSignUp() async {
    print(user);
    print(password);
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: user.email.toString(), password: password.toString());
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "The account already exists for this Email";
      } else {
        return "Something went wrong";
      }
    }
  }

  Future<void> addUserToDB(
      {String? uid,
      String? username,
      String? email,
      DateTime? timestamp}) async {
    user = UserModel(
        uid: uid, username: username, email: email, timestamp: timestamp);

    await userRef.doc(uid).set(user.toMap());
  }

  createUserToFireStore() {
    addUserToDB(
        uid: firebaseAuth.currentUser?.uid,
        email: firebaseAuth.currentUser?.email,
      username: user.username,
      timestamp: DateTime.now()
    );
  }
}
