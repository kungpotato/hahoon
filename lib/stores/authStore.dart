import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:hahoon/models/userData.dart';
import 'package:hahoon/modules/helpers/api.dart';
import 'package:mobx/mobx.dart';
import 'package:requests/requests.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'authStore.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  UserData dbUser;

  @observable
  User fbUser;

  Future<String> getFireBaseToken() async {
    final user = FirebaseAuth.instance.currentUser;
    return await user.getIdToken(true);
  }

  Stream<User> onAuthStateChangedFirebase() {
    return FirebaseAuth.instance.authStateChanges();
  }

  @action
  void setDbUser(UserData dbUser) {
    this.dbUser = dbUser;
  }

  @action
  void setFbUser(User fbUser) {
    this.fbUser = fbUser;
  }

  void clearStore() {
    this.setFbUser(null);
    this.setDbUser(null);
  }

  Stream<UserCredential> signInWithCloud(String email, String password) {
    final response = Stream.fromFuture(Requests.post(API.signIn,
            body: {"email": email, "password": password},
            bodyEncoding: RequestBodyEncoding.FormURLEncoded))
        .flatMap((resp) {
      final token = resp.content();
      return Stream.fromFuture(
          FirebaseAuth.instance.signInWithCustomToken(token));
    });
    return response;
  }

  Future<void> signOut() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await FirebaseAuth.instance.signOut();
      this.setFbUser(null);
      this.setDbUser(null);
      prefs.clear();
    } catch (err, s) {
      print(err);
      FirebaseCrashlytics.instance.recordError(err, s);
    }
  }

  Stream<Response> createUSer(String fullName, String email, String password) {
    final dataSave = UserData(
        fullName: fullName,
        password: password,
        email: email,
        createAt: Timestamp.now());
    print(dataSave.toMap());
    final response = Stream.fromFuture(Requests.post(API.createUser,
            body: dataSave.toMap(),
            bodyEncoding: RequestBodyEncoding.FormURLEncoded))
        .flatMap((resp) {
      return Stream.value(resp);
    });
    return response;
  }

  // Stream<UserData> snapshotDbUser(String uid, String client) {
  //   final userRef = FirebaseFirestore.instance.doc('client/$client/users/$uid');
  //   return userRef.snapshots().map((doc) {
  //     return UserData.fromMap(
  //         {'id': doc.id, 'selfRef': doc.reference, ...doc.data()});
  //   }).defaultIfEmpty(UserData(createAt: Timestamp.now()));
  // }

  Stream<UserData> getDbUser(String uid) {
    final userRef = FirebaseFirestore.instance.doc('users/$uid');
    return Stream.fromFuture(userRef.get()).map((doc) {
      print(doc.id);
      return UserData.fromMap(
          {'id': doc.id, 'selfRef': doc.reference, ...doc.data()});
    }).defaultIfEmpty(null);
  }

  Stream updateDbUser(DocumentReference ref, UserData data) {
    return Stream.fromFuture(ref.update(data.toMap()));
  }

  void testCall() {
    HttpsCallable callable = FirebaseFunctions.instance.httpsCallable('addTest',
        options: HttpsCallableOptions(timeout: Duration(seconds: 5)));
    Stream.fromFuture(callable.call({'name': 'potato'})).listen((event) {
      print(event.data);
    }, onError: (err) {
      print(err);
    });
  }
}
