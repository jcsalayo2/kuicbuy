part of 'productdetails_bloc.dart';

class ProductDetailsState extends Equatable {
  final List<String> images;
  final int selectedImageIndex;
  final ProductDetailsStatus productDetailsStatus;

  const ProductDetailsState({
    required this.images,
    required this.selectedImageIndex,
    required this.productDetailsStatus,
  });

  @override
  List<Object> get props => [
        images,
        selectedImageIndex,
        productDetailsStatus,
      ];

  ProductDetailsState.initial()
      : images = [],
        selectedImageIndex = 0,
        productDetailsStatus = ProductDetailsStatus.initial;

  ProductDetailsState copyWith({
    int? selectedImageIndex,
    List<String>? images,
    ProductDetailsStatus? productDetailsStatus,
  }) {
    return ProductDetailsState(
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      images: images ?? this.images,
      productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
    );
  }
}
