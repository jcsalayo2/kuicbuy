// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Account accountFromJson(String str) => Account.fromJson(json.decode(str));

String accountToJson(Account data) => json.encode(data.toJson());

class Account {
  String fullName;
  String avatar;
  bool isSeller;

  Account({
    required this.fullName,
    required this.avatar,
    required this.isSeller,
  });

  factory Account.fromJson(Map<String, dynamic> json) => Account(
        fullName: json["fullName"],
        avatar: json["avatar"],
        isSeller: json["isSeller"],
      );

  Map<String, dynamic> toJson() => {
        "fullName": fullName,
        "avatar": avatar,
        "isSeller": isSeller,
      };
}
