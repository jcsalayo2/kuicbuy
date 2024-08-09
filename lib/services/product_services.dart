import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

import '../models/product_model.dart';

class ProductServices {
  final CollectionReference products =
      FirebaseFirestore.instance.collection('products');

  final storage = FirebaseStorage.instance;

  Future<List<Product>> getProducts() async {
    var qSnapShot = await products.get();
    return qSnapShot.docs.map((doc) {
      Object? response = doc.data();
      return Product.fromJson(response as Map<String, dynamic>);
    }).toList();
  }

  Future<List<Product>> getProductsByIds({required List<String> saved}) async {
    var qSnapShot =
        await products.where(FieldPath.documentId, whereIn: saved).get();
    return qSnapShot.docs.map((doc) {
      Object? response = doc.data();
      return Product.fromJson(response as Map<String, dynamic>);
    }).toList();
  }

  Future<bool> addProduct(
      {required Product product,
      required List<XFile> coverImages,
      XFile? thumbnailImage}) async {
    try {
      String id = products.doc().id;
      product.id = id;

      // TO-DO Optimize

      product.images.thumbnail =
          await uploadImageToStorage(thumbnailImage!, id);

      for (var image in coverImages) {
        product.images.cover.add(await uploadImageToStorage(image, id));
      }

      var data = product.toJson();

      await products.doc(id).set(data);
      // _firebaseAuth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> uploadImageToStorage(XFile file, String productId) async {
    try {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('products/$productId')
          .child('/${file.name}');

      final metadata = SettableMetadata(
        contentType: 'image/jpeg',
        customMetadata: {'picked-file-path': file.path},
      );

      // if (kIsWeb) {
      await ref.putData(await file.readAsBytes(), metadata);
      // } else {
      //   uploadTask = ref.putFile(io.File(file.path), metadata);
      // }
      return ref.getDownloadURL();
    } catch (e) {
      print(
          "Something went wrong (product_service.dart uploadImageToStorage Method): $e");
      return "ERROR";
    }
  }

  Future addToSaved({required String id, required String uid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('saved')
          .doc(id)
          .set({});
    } catch (ex) {
      throw ("Something went wrong (product_service.dart addToSaved Method): $ex");
    }
  }

  Future removeToSaved({required String id, required String uid}) async {
    try {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('saved')
          .doc(id)
          .delete();
    } catch (ex) {
      throw ("Something went wrong (product_service.dart removeToSaved Method): $ex");
    }
  }
}
