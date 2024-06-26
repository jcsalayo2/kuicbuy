part of 'product_list_bloc.dart';

class ProductListState extends Equatable {
  final List<Product> products;

  const ProductListState({required this.products});

  ProductListState.initial() : products = [];

  @override
  List<Object> get props => [products];

  ProductListState copyWith({
    List<Product>? products,
  }) {
    return ProductListState(
      products: products ?? this.products,
    );
  }
}
