class UserModel {
  String? email;
  String? uid;
  String? username;
  DateTime? timestamp;
  String? phone;
  String? job;


  UserModel({this.email, this.uid, this.username, this.timestamp,this.phone,this.job});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "username": username,
      "email": email,
      "timestamp": timestamp,
      "phone":phone,
      "job" : job,
    };
  }

  UserModel.fromMap(Map<String, dynamic> mapData) {
    uid = mapData["uid"];
    username = mapData["username"];
    email = mapData["email"];
    phone = mapData["phone"];
    job = mapData["job"];
  }
}