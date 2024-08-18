// To parse this JSON data, do
//
//     final message = messageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Message> messageFromJson(String str) =>
    List<Message>.from(json.decode(str).map((x) => Message.fromJson(x)));

String messageToJson(List<Message> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Message {
  String? id;
  String message;
  String messageType;
  String sender;
  DateTime timestamp;

  Message({
    this.id,
    required this.message,
    required this.messageType,
    required this.sender,
    required this.timestamp,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["id"],
        message: json["message"],
        messageType: json["messageType"],
        sender: json["sender"],
        timestamp: json["timestamp"].toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "message": message,
        "messageType": messageType,
        "sender": sender,
        "timestamp": timestamp,
      };
}
