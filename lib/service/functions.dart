import 'package:cloud_firestore/cloud_firestore.dart';

class dataGetFunctions{

  static Future<String> getTransactionID(
      String accName, CollectionReference document) async {
    String initialId = "${accName}001";
    String newId = initialId;

    DocumentSnapshot docs = await document.doc(initialId).get();
    try {
      if (docs.exists) {
        QuerySnapshot querySnapshot = await document
            .orderBy(FieldPath.documentId)
            .startAt([initialId]).get();
        if (querySnapshot.docs.isNotEmpty) {
          String lastId = querySnapshot.docs.last.id;

          int idNumber = int.parse(lastId.replaceAll(accName, '')) + 1;
          newId = '$accName${idNumber.toString().padLeft(3, '0')}';
        }
      }
    } catch (e) {
      print(e);
    }

    return newId.toString();
  }
}