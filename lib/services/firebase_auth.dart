import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
      if (e.code == 'invalid-login-credentials') {
        return 'Wrong email or password.';
      }
      return e.message;
    }
  }

  Future<dynamic> signUp(
      {required String email,
      required String password,
      required String name}) async {
    try {
      var result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      setUpUser(name: name, uid: result.user!.uid);
      return true;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future<dynamic> setUpUser({required String name, required String uid}) async {
    try {
      Map<String, dynamic> data = {
        "avatar":
            "https://gravatar.com/avatar/b6ae0b40c9a6498a2b8f1bd23d346d02?s=400&d=identicon&r=x",
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
