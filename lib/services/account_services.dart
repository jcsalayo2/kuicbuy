import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuicbuy/models/account_model.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AccountServices {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  final storage = FirebaseStorage.instance;

  Future<Account> getUser({required String userId}) async {
    var dSnapshot = await users.doc(userId).get();

    var url =
        await storage.ref().child('${dSnapshot['avatar']}').getDownloadURL();

    return Account(
      uid: dSnapshot['uid'],
      avatar: url,
      fullName: dSnapshot['fullName'],
      isSeller: dSnapshot['isSeller'],
    );
  }
}
