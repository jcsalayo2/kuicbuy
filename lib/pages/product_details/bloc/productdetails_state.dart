part of 'productdetails_bloc.dart';

class ProductDetailsState extends Equatable {
  final List<String> images;
  final int selectedImageIndex;
  final ProductDetailsStatus productDetailsStatus;
  final GeminiStatus geminiStatus;
  final String geminiResponse;
  final bool isSaved;
  final Chat? existingChat;
  final DateTime timestamp; // for force emit

  const ProductDetailsState({
    required this.images,
    required this.selectedImageIndex,
    required this.productDetailsStatus,
    required this.geminiStatus,
    required this.geminiResponse,
    required this.isSaved,
    this.existingChat,
    required this.timestamp,
  });

  @override
  List<Object> get props => [
        images,
        selectedImageIndex,
        productDetailsStatus,
        geminiStatus,
        geminiResponse,
        isSaved,
        timestamp,
      ];

  ProductDetailsState.initial()
      : images = [],
        selectedImageIndex = 0,
        productDetailsStatus = ProductDetailsStatus.initial,
        geminiStatus = GeminiStatus.idle,
        geminiResponse = '',
        isSaved = false,
        existingChat = null,
        timestamp = DateTime.now();

  ProductDetailsState copyWith({
    int? selectedImageIndex,
    List<String>? images,
    ProductDetailsStatus? productDetailsStatus,
    GeminiStatus? geminiStatus,
    String? geminiResponse,
    bool? isSaved,
    Chat? chat,
    DateTime? timestamp,
  }) {
    return ProductDetailsState(
      selectedImageIndex: selectedImageIndex ?? this.selectedImageIndex,
      images: images ?? this.images,
      productDetailsStatus: productDetailsStatus ?? this.productDetailsStatus,
      geminiStatus: geminiStatus ?? this.geminiStatus,
      geminiResponse: geminiResponse ?? this.geminiResponse,
      isSaved: isSaved ?? this.isSaved,
      existingChat: chat,
      timestamp: timestamp ?? this.timestamp,
    );
  }
}
