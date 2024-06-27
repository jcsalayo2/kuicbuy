part of 'productdetails_bloc.dart';

class ProductDetailsState extends Equatable {
  final List<String> images;
  final int selectedImageIndex;
  final ProductDetailsStatus productDetailsStatus;
  final GeminiStatus geminiStatus;
  final String geminiResponse;

  const ProductDetailsState({
    required this.images,
    required this.selectedImageIndex,
    required this.productDetailsStatus,
    required this.geminiStatus,
    required this.geminiResponse,
  });

  @override
  List<Object> get props => [
        images,
        selectedImageIndex,
        productDetailsStatus,
        geminiStatus,
        geminiResponse,
      ];

  ProductDetailsState.initial()
      : images = [],
        selectedImageIndex = 0,
        productDetailsStatus = ProductDetailsStatus.initial,
        geminiStatus = GeminiStatus.idle,
        geminiResponse = '';

  ProductDetailsState copyWith({
    int? selectedImageIndex,
    List<String>? images,
    ProductDetailsStatus? productDetailsStatus,
    GeminiStatus? geminiStatus,
    String? geminiResponse,
  }) {
    return ProductDetailsState(
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      images: images ?? this.images,
      productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
      geminiStatus: geminiStatus ?? this.geminiStatus,
      geminiResponse: geminiResponse ?? this.geminiResponse,
    );
  }
}
