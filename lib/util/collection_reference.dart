import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../util/data_base_name.dart';

class CollectionReferenceData {
  static User? user = FirebaseAuth.instance.currentUser;

  static CollectionReference accountDetails = FirebaseFirestore.instance
      .collection(DataBaseName.user)
      .doc(user?.uid)
      .collection(DataBaseName.accDetails);

  static CollectionReference accounts = FirebaseFirestore.instance
      .collection(DataBaseName.user)
      .doc(user?.uid)
      .collection(DataBaseName.accDetails)
      .doc("balance001")
      .collection(DataBaseName.accounts);

  static CollectionReference transaction = FirebaseFirestore.instance
      .collection(DataBaseName.user)
      .doc(user?.uid)
      .collection(DataBaseName.accDetails)
      .doc("balance001")
      .collection(DataBaseName.transaction);

  static CollectionReference debt = FirebaseFirestore.instance
      .collection(DataBaseName.user)
      .doc(user?.uid)
      .collection(DataBaseName.accDetails)
      .doc("balance001")
      .collection(DataBaseName.debt);
}
