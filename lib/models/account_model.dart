// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  String uid;
  String fullName;
  String avatar;
  bool isSeller;

  Account({
    required this.uid,
    required this.fullName,
    required this.avatar,
    required this.isSeller,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        uid: json["uid"],
        fullName: json["fullName"],
        avatar: json["avatar"],
        isSeller: json["isSeller"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "fullName": fullName,
        "avatar": avatar,
        "isSeller": isSeller,
      };
}
