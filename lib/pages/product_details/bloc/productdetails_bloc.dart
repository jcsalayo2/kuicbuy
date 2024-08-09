import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuicbuy/bloc/main_bloc.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/services/generative_ai_service.dart';
import 'package:kuicbuy/services/product_services.dart';

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
    on<AskGemini>(_askGemini);
    on<ToggleSaved>(_toggleIsSaved);
    on<AddOrRemoveToSaved>(_addOrRemoveToSaved);
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

  FutureOr<void> _askGemini(
      AskGemini event, Emitter<ProductDetailsState> emit) async {
    emit(state.copyWith(
      geminiStatus: GeminiStatus.loading,
      geminiResponse: '',
    ));

    // var imgBytes = await state.images[0].readAsBytes();

    var response =
        await GenerativeAIService().getProductDetails(title: event.title);

    emit(state.copyWith(
      geminiStatus: GeminiStatus.idle,
      geminiResponse: response,
    ));
  }

  FutureOr<void> _toggleIsSaved(
      ToggleSaved event, Emitter<ProductDetailsState> emit) {
    emit(state.copyWith(
      isSaved: event.isSaved,
    ));
  }

  FutureOr<void> _addOrRemoveToSaved(
      AddOrRemoveToSaved event, Emitter<ProductDetailsState> emit) async {
    if (event.uid == "") {
      return;
    }
    try {
      if (event.isSaved) {
        //remove to save
        await ProductServices().removeToSaved(id: event.id, uid: event.uid);
      } else {
        //add to save
        await ProductServices().addToSaved(id: event.id, uid: event.uid);
      }

      add(ToggleSaved(isSaved: !event.isSaved));
      event.mainBloc.add(GetSaved(uid: event.uid));
    } catch (ex) {
      throw ("Something went wrong (productdetails_bloc.dart _addOrRemoveToSaved Method : $ex)");
    }
  }
}
