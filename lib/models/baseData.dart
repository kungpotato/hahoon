import 'package:cloud_firestore/cloud_firestore.dart';

class BaseData {
  final Timestamp createAt;
  final Timestamp deleteAt;
  final Timestamp updateAt;
  final String id;
  final bool deleted;
  final DocumentReference selfRef;

  BaseData(
      {this.createAt,
      this.deleteAt,
      this.id,
      this.deleted = false,
      this.selfRef,
      this.updateAt}) {
    assert(createAt != null);
  }

  BaseData.fromMap(Map<String, dynamic> data)
      : id = data['id'],
        createAt = data['createAt'],
        deleteAt = data['deleteAt'],
        updateAt = data['updateAt'],
        deleted = data['deleted'] ?? false,
        selfRef = data['selfRef'] {
    assert(createAt != null);
  }

  Map<String, dynamic> toMap() {
    return {
      'createAt': createAt,
      'deleteAt': deleteAt,
      'updateAt': updateAt,
      'deleted': deleted,
    };
  }
}
