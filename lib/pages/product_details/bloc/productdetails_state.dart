part of 'productdetails_bloc.dart';

class ProductDetailsState extends Equatable {
  final List<String> images;
  final int selectedImageIndex;
  final ProductDetailsStatus productDetailsStatus;
  final GeminiStatus geminiStatus;
  final String geminiResponse;
  final bool isSaved;

  const ProductDetailsState({
    required this.images,
    required this.selectedImageIndex,
    required this.productDetailsStatus,
    required this.geminiStatus,
    required this.geminiResponse,
    required this.isSaved,
  });

  @override
  List<Object> get props => [
        images,
        selectedImageIndex,
        productDetailsStatus,
        geminiStatus,
        geminiResponse,
        isSaved,
      ];

  ProductDetailsState.initial()
      : images = [],
        selectedImageIndex = 0,
        productDetailsStatus = ProductDetailsStatus.initial,
        geminiStatus = GeminiStatus.idle,
        geminiResponse = '',
        isSaved = false;

  ProductDetailsState copyWith({
    int? selectedImageIndex,
    List<String>? images,
    ProductDetailsStatus? productDetailsStatus,
    GeminiStatus? geminiStatus,
    String? geminiResponse,
    bool? isSaved,
  }) {
    return ProductDetailsState(
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      images: images ?? this.images,
      productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
      geminiStatus: geminiStatus ?? this.geminiStatus,
      geminiResponse: geminiResponse ?? this.geminiResponse,
      isSaved: isSaved ?? this.isSaved,
    );
  }
}
