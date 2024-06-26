import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/services/product_services.dart';

part 'product_list_event.dart';
part 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  ProductListBloc() : super(ProductListState.initial()) {
    on<ProductListEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetProducts>(_getProducts);
  }

  FutureOr<void> _getProducts(
      GetProducts event, Emitter<ProductListState> emit) async {
    var products = await ProductServices().getProducts();

    emit(state.copyWith(products: products));
  }
}
