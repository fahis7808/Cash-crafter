import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:money_manage_app2/Model/user_model.dart';

class Auth {
  final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

  UserModel? firebaseUser(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserModel(user.uid, user.email);
  }

  Future<UserModel?> handleSignUp(String email, String password) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return firebaseUser(result.user);
  }
}
