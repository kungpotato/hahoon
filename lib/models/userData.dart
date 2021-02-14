import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hahoon/models/baseData.dart';

class UserData extends BaseData {
  final String username;
  final String password;
  final String email;
  final String avatar;
  final String name;
  final String surname;
  final String phone;
  final String authToken;

  UserData(
      {this.username,
      this.password,
      this.email,
      this.phone,
      this.avatar,
      this.name,
      this.surname,
      this.authToken,
      Timestamp createAt,
      Timestamp deleteAt,
      Timestamp updateAt,
      bool deleted,
      String id,
      DocumentReference selfRef})
      : super(
            createAt: createAt,
            deleteAt: deleteAt,
            updateAt: updateAt,
            deleted: deleted,
            id: id,
            selfRef: selfRef);

  UserData.fromMap(Map<String, dynamic> data)
      : username = data['username'],
        password = data['password'],
        email = data['email'],
        avatar = data['avatar'],
        name = data['name'],
        surname = data['surname'],
        phone = data['phone'],
        authToken = data['authToken'],
        super.fromMap(data);

  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'username': username,
      'password': password,
      'email': email,
      'avatar': avatar,
      'name': name,
      'surname': surname,
      'phone': phone,
      'authToken': authToken
    };
  }
}
