class UserModel {
  String? email;
  String? uid;
  String? username;
  DateTime? timestamp;

  UserModel({this.email, this.uid, this.username, this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "timestamp": timestamp,
    };
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData["uid"];
    username = mapData["username"];
    email = mapData["email"];
  }
}