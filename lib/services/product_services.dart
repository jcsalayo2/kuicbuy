import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';

class ProductServices {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  Future<List<Product>> getProducts() async {
    var qSnapShot = await products.get();
    return qSnapShot.docs.map((doc) {
      Object? response = doc.data();
      return Product.fromJson(response as Map<String, dynamic>);
    }).toList();
  }
}
