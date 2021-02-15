import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hahoon/models/baseData.dart';

class UserData extends BaseData {
  final String fullName;
  final String password;
  final String email;

  UserData(
      {@required this.fullName,
      @required this.password,
      @required this.email,
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
      : fullName = data['fullName'],
        password = data['password'],
        email = data['email'],
        super.fromMap(data);

  Map<String, dynamic> toMap() {
    return {
      ...super.toMap(),
      'fullName': fullName,
      'password': password,
      'email': email,
    };
  }
}
