import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalDB {
  static const db = FlutterSecureStorage();

  static saveToDB(String key, String value) async {
    await db.write(key: key, value: value);
  }

  static readFromDB(String key) async {
    String? data = await db.read(key: key);
    return data;
  }

  static deleteFromDB(String key) async {
    await db.delete(key: key);
  }
}
