import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:math';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  FirebaseAuthService(this._firebaseAuth);

  Future<dynamic> logIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<dynamic> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await setUpUser(name: name, uid: result.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<dynamic> setUpUser({required String name, required String uid}) async {
    final random = Random();

    try {
      Map<String, dynamic> data = {
        "uid": uid,
        "avatar": "avatars/user${random.nextInt(6) + 1}.png",
        "fullName": name,
        "isSeller": false
      };
      await users.doc(uid).set(data);
      // _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
