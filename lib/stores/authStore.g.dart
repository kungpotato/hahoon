// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authStore.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AuthStore on _AuthStore, Store {
  final _$dbUserAtom = Atom(name: '_AuthStore.dbUser');

  @override
  UserData get dbUser {
    _$dbUserAtom.reportRead();
    return super.dbUser;
  }

  @override
  set dbUser(UserData value) {
    _$dbUserAtom.reportWrite(value, super.dbUser, () {
      super.dbUser = value;
    });
  }

  final _$fbUserAtom = Atom(name: '_AuthStore.fbUser');

  @override
  User get fbUser {
    _$fbUserAtom.reportRead();
    return super.fbUser;
  }

  @override
  set fbUser(User value) {
    _$fbUserAtom.reportWrite(value, super.fbUser, () {
      super.fbUser = value;
    });
  }

  final _$_AuthStoreActionController = ActionController(name: '_AuthStore');

  @override
  void setDbUser(UserData dbUser) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setDbUser');
    try {
      return super.setDbUser(dbUser);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFbUser(User fbUser) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setFbUser');
    try {
      return super.setFbUser(fbUser);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dbUser: ${dbUser},
fbUser: ${fbUser}
    ''';
  }
}
