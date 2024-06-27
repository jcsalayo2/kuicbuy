import 'dart:async';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/services/product_services.dart';

part 'add_product_event.dart';
part 'add_product_state.dart';

class AddProductBloc extends Bloc<AddProductEvent, AddProductState> {
  AddProductBloc() : super(AddProductState.initial()) {
    on<AddProductEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AddCoverImages>(_addCoverImages);
    on<AddThumbnail>(_addThumbnail);
    on<CreateProduct>(_addProduct);
  }

  FutureOr<void> _addCoverImages(
      AddCoverImages event, Emitter<AddProductState> emit) async {
    List<Uint8List> coverImagesAsByte = [];

    for (var image in event.converImages) {
      coverImagesAsByte.add(await image.readAsBytes());
    }
    emit(state.copyWith(
      coverImages: event.converImages,
      coverImagesAsByte: coverImagesAsByte,
    ));
  }

  FutureOr<void> _addThumbnail(
      AddThumbnail event, Emitter<AddProductState> emit) async {
    var thumbnailImageAsByte = await event.thumbnailImage.readAsBytes();
    emit(state.copyWith(
      thumbnailImage: event.thumbnailImage,
      thumbnailImageAsByte: thumbnailImageAsByte,
      timestamp: DateTime.now(),
    ));
  }

  FutureOr<void> _addProduct(
      CreateProduct event, Emitter<AddProductState> emit) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    if (auth.currentUser == null) return;

    emit(state.copyWith(
      productStatus: ProductStatus.uploading,
    ));

    Product product = Product(
      price: event.price,
      quantity: event.initialQuantity,
      sellerId: auth.currentUser!.uid,
      sku: event.sku,
      title: event.title,
      description: Description(
          short: event.shortDescription, long: event.longDescription),
      images: Images(thumbnail: "thumbnail", cover: []),
    );

    var result = await ProductServices().addProduct(
      product: product,
      coverImages: state.coverImages,
      thumbnailImage: state.thumbnailImage,
    );

    if (result) {
      emit(state.copyWith(
        productStatus: ProductStatus.done,
      ));
    } else {
      emit(state.copyWith(
        productStatus: ProductStatus.error,
      ));
      emit(state.copyWith(
        productStatus: ProductStatus.initial,
      ));
    }
  }
}
