import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../Model/user_model.dart';
import '../../../service/secure_storage.dart';

class AuthenticationProvider extends ChangeNotifier {
  UserModel user = UserModel();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final userRef = FirebaseFirestore.instance.collection("users");
  String? password;
  String? email;

  Future<String> login() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.toString(), password: password.toString());
      saveToLocalDB(userCredential.user?.uid);
      return "Logged In";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return "Something went wrong";
    }
  }

  Future<String> handleSignUp() async {
    print(user);
    print(password);
    try {
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
              email: user.email.toString(), password: password.toString());

      saveToLocalDB(userCredential.user?.uid);
      if(userCredential.user != null){
        createUserToFireStore();
      }
      return "Signed Up";
    } on FirebaseAuthException catch (e) {
      if (e.code == "email-already-in-use") {
        return "The account already exists for this Email";
      } else {
        return "Something went wrong";
      }
    }
  }

  final GoogleSignIn googleSignIn = GoogleSignIn();

  Future<String> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) return "No user found on this email";
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await firebaseAuth.signInWithCredential(credential);
      final User? user = userCredential.user;
       saveToLocalDB(user?.uid);
      if (userCredential.user != null) {
        addUserToDB(
            uid: user?.uid,
            username: user?.displayName,
            email: user?.email,
            timestamp: DateTime.now());
      }
      return "Signed on Google";
    } catch (e) {
      return "Some thing went wrong";
    }
  }

  Future<User?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;

        final OAuthCredential credential =
            FacebookAuthProvider.credential(accessToken.tokenString);
        final UserCredential userCredential =
            await firebaseAuth.signInWithCredential(credential);
        final User? user = userCredential.user;

        if (user != null) {
          return user;
        }
      } else if (result.status == LoginStatus.cancelled) {
        print('Facebook login cancelled');
      } else {
        print('Facebook login failed: ${result.message}');
      }
    } catch (e) {
      print('Error during Facebook sign-in: $e');
    }
    return null;
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

  saveToLocalDB(id) {
    LocalDB.saveToDB("LoginID", id);
  }

  createUserToFireStore() {
    addUserToDB(
        uid: firebaseAuth.currentUser?.uid,
        email: firebaseAuth.currentUser?.email,
        username: user.username,
        timestamp: DateTime.now());
  }
}
