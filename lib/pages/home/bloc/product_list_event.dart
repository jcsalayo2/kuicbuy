part of 'product_list_bloc.dart';

abstract class ProductListEvent extends Equatable {
  const ProductListEvent();

  @override
  List<Object> get props => [];
}

class GetProducts extends ProductListEvent {
  @override
  List<Object> get props => [];

  const GetProducts();
}
