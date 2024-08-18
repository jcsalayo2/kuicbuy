// To parse this JSON data, do
//
//     final chat = chatFromJson(jsonString);

import 'package:kuicbuy/models/product_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<Chat> chatFromJson(String str) =>
    List<Chat>.from(json.decode(str).map((x) => Chat.fromJson(x)));

String chatToJson(List<Chat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Chat {
  String id;
  List<String> members;
  String productId;
  String lastMessage;
  DateTime lastMessageTimestamp;
  Product? product;
  String sender;

  Chat({
    required this.id,
    required this.members,
    required this.productId,
    required this.lastMessage,
    required this.lastMessageTimestamp,
    required this.sender,
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["id"],
        members: List<String>.from(json["members"].map((x) => x)),
        productId: json["productId"],
        lastMessage: json["lastMessage"],
        lastMessageTimestamp: json["lastMessageTimestamp"].toDate(),
        sender: json["sender"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "members": List<dynamic>.from(members.map((x) => x)),
        "productId": productId,
        "lastMessage": lastMessage,
        "lastMessageTimestamp": lastMessageTimestamp,
        "sender": sender,
      };
}
