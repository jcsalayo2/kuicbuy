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

  Future<List<String>> getSaved({required String userId}) async {
    var qSnapshot = await users.doc(userId).collection("saved").get();

    final allData = qSnapshot.docs.map((doc) => doc.id).toList();

    return allData;
  }

  Future<void> addChat(
      {required String userId,
      required String chatId,
      required String sellerId}) async {
    try {
      users.doc(userId).collection("chats").doc(chatId).set({});
      users.doc(sellerId).collection("chats").doc(chatId).set({});
    } catch (ex) {
      throw ("Something went wrong (account_service.dart addChat Method): $ex");
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> listenToChatIds(
      {required String userId}) {
    try {
      return users.doc(userId).collection("chats").snapshots();
    } catch (ex) {
      throw ("Something went wrong (account_service.dart getChatsId Method): $ex");
    }
  }
}
