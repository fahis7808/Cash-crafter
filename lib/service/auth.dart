import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:money_manage_app2/Model/user_model.dart';

class Auth {
  static final auth.FirebaseAuth firebaseAuth = auth.FirebaseAuth.instance;

 static UserModel? firebaseUser(auth.User? user) {
    if (user == null) {
      return null;
    }
    return UserModel();
  }

  Future<UserModel?> handleSignUp(String email, String password) async {
    final result = await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    return firebaseUser(result.user);
  }
}
