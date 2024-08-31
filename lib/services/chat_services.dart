import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/account_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:kuicbuy/models/chat_model.dart';
import 'package:kuicbuy/models/message_model.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/services/account_services.dart';
import 'package:kuicbuy/services/product_services.dart';

class ChatServices {
  final CollectionReference chats =
      FirebaseFirestore.instance.collection('chats');

  final storage = FirebaseStorage.instance;

  Future<Chat> startChat(
      {required String uid, required Product product}) async {
    try {
      Timestamp timeStamp = Timestamp.fromDate(DateTime.now());

      String id = chats.doc().id;

      var chatData = {
        "id": id,
        "lastMessage":
            "Hello, I am interested in your product ${product.title}",
        "lastMessageTimestamp": timeStamp,
        "members": [uid, product.sellerId],
        "productId": product.id,
        "sender": uid,
      };

      await chats.doc(id).set(chatData);

      AccountServices()
          .addChat(userId: uid, chatId: id, sellerId: product.sellerId);

      var messages = chats.doc(id).collection("messages");

      String messageId = messages.doc().id;

      var messageData = {
        "id": messageId,
        "message": "Hello, I am interested in your product ${product.title}",
        "messageType": MessageType.text.name,
        "sender": uid,
        "timestamp": timeStamp,
      };

      await messages.doc(messageId).set(messageData);

      return Chat.fromJson(chatData);
    } catch (ex) {
      throw ("Something went wrong (chat_services.dart startChat Method): $ex");
    }
  }

  Future<String?> isChatExist(
      {required String uid, required Product product}) async {
    try {
      var myChats = await chats
          .where("members", isEqualTo: [uid, product.sellerId])
          .where("productId", isEqualTo: product.id)
          .get();

      if (myChats.size >= 1) {
        return myChats.docs.first.id; // return first chat ID
      }

      return null;
    } catch (ex) {
      throw ("Something went wrong (chat_services.dart isChatExist Method): $ex");
    }
  }

  Stream<QuerySnapshot<Object?>> listenToChats(
      {required String uid, required List<String> chatIds}) {
    // var listOfChats = await AccountServices().listenChatIds(userId: uid);

    var qSnapShot = chats
        .where(FieldPath.documentId, whereIn: chatIds)
        .orderBy("lastMessageTimestamp", descending: true)
        .snapshots();

    return qSnapShot;
  }

  Stream<QuerySnapshot<Object?>> listenToConversation({
    required String chatId,
  }) {
    var qSnapShot = chats
        .doc(chatId)
        .collection("messages")
        .orderBy("timestamp", descending: true)
        .snapshots();

    return qSnapShot;
  }

  Future<void> sendMessage({
    required String uid,
    required Message message,
    required String chatId,
  }) async {
    try {
      message.id = chats.doc(chatId).collection("messages").doc().id;

      chats
          .doc(chatId)
          .collection("messages")
          .doc(message.id)
          .set(message.toJson());
    } catch (ex) {
      throw ("Something went wrong (chat_services.dart sendMessage Method): $ex");
    }
  }

  Future<void> updateChat(
      {required String chatId, required Message message}) async {
    try {
      var data = {
        "lastMessageTimestamp": message.timestamp,
        "lastMessage": message.message,
        "sender": message.sender,
      };
      chats.doc(chatId).update(data);
    } catch (ex) {
      throw ("Something went wrong (chat_services.dart updateChat Method): $ex");
    }
  }

  Future<Chat> getChatById({required String chatId}) async {
    var chat = await chats.doc(chatId).get();

    Object? response = chat.data();
    return Chat.fromJson(response as Map<String, dynamic>);
  }
}
