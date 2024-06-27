import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuicbuy/models/product_model.dart';

import '../../../constants/constant.dart';

part 'productdetails_event.dart';
part 'productdetails_state.dart';

class ProductDetailsBloc
    extends Bloc<ProductdetailsEvent, ProductDetailsState> {
  ProductDetailsBloc() : super(ProductDetailsState.initial()) {
    on<ProductdetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<CompileAllImages>(_compileImages);
    on<SetSelectedImageIndex>(_setSelectedImageIndex);
  }

  FutureOr<void> _compileImages(
      CompileAllImages event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(
      productDetailsStatus: ProductDetailsStatus.loading,
    ));
    List<String> images = [];

    images.add(event.images.thumbnail);

    for (var image in event.images.cover) {
      images.add(image);
    }

    emit(state.copyWith(
      images: images,
      productDetailsStatus: ProductDetailsStatus.done,
    ));
  }

  FutureOr<void> _setSelectedImageIndex(
      SetSelectedImageIndex event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(
      selectedImageIndex: event.index,
    ));
  }
}
