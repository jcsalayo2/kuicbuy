// To parse this JSON data, do
//
//     final account = accountFromJson(jsonString);

import 'package:kuicbuy/models/account_model.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

List<GroupedSavedProducts> groupedSavedProductsFromJson(String str) =>
    List<GroupedSavedProducts>.from(
        json.decode(str).map((x) => GroupedSavedProducts.fromJson(x)));

String groupedSavedProductsToJson(List<GroupedSavedProducts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<GroupedSavedProducts> groupedSavedProductsFromMap(
    Map<String, List<Product>> str, List<Account> accounts) {
  List<GroupedSavedProducts> list = [];
  str.forEach((key, value) {
    list.add(GroupedSavedProducts(
        seller: accounts.where((accounts) => accounts.uid == key).first,
        products: value));
  });
  return list;
}

class GroupedSavedProducts {
  Account seller;
  List<Product> products;

  GroupedSavedProducts({
    required this.seller,
    required this.products,
  });

  factory GroupedSavedProducts.fromJson(Map<String, dynamic> json) =>
      GroupedSavedProducts(
        seller: Account.fromJson(json["seller"]),
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "seller": seller,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}
