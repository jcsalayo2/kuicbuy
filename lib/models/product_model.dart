// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  double price;
  int quantity;
  String sellerId;
  String sku;
  String title;
  Description description;
  Images images;

  Product({
    required this.price,
    required this.quantity,
    required this.sellerId,
    required this.sku,
    required this.title,
    required this.description,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        price: json["price"],
        quantity: json["quantity"],
        sellerId: json["sellerId"],
        sku: json["sku"],
        title: json["title"],
        description: Description.fromJson(json["description"]),
        images: Images.fromJson(json["images"]),
      );

  Map<String, dynamic> toJson() => {
        "price": price,
        "quantity": quantity,
        "sellerId": sellerId,
        "sku": sku,
        "title": title,
        "description": description.toJson(),
        "images": images.toJson(),
      };
}

class Description {
  String short;
  String long;

  Description({
    required this.short,
    required this.long,
  });

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        short: json["short"],
        long: json["long"],
      );

  Map<String, dynamic> toJson() => {
        "short": short,
        "long": long,
      };
}

class Images {
  String thumbnail;
  List<String> cover;

  Images({
    required this.thumbnail,
    required this.cover,
  });

  factory Images.fromJson(Map<String, dynamic> json) => Images(
        thumbnail: json["thumbnail"],
        cover: List<String>.from(json["cover"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "cover": List<dynamic>.from(cover.map((x) => x)),
      };
}
