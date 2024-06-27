part of 'add_product_bloc.dart';

class AddProductState extends Equatable {
  final List<XFile> coverImages;
  final List<Uint8List> coverImagesAsByte;
  final XFile? thumbnailImage;
  final Uint8List? thumbnailImageAsByte;
  final DateTime timestamp;
  final ProductStatus productStatus;

  const AddProductState({
    required this.coverImages,
    required this.coverImagesAsByte,
    required this.thumbnailImage,
    required this.thumbnailImageAsByte,
    required this.timestamp,
    required this.productStatus,
  });

  @override
  List<Object> get props => [
        coverImages,
        timestamp,
        productStatus,
      ];

  AddProductState.initial()
      : coverImages = [],
        coverImagesAsByte = [],
        thumbnailImage = null,
        thumbnailImageAsByte = null,
        timestamp = DateTime.now(),
        productStatus = ProductStatus.initial;

  AddProductState copyWith({
    List<XFile>? coverImages,
    List<Uint8List>? coverImagesAsByte,
    XFile? thumbnailImage,
    Uint8List? thumbnailImageAsByte,
    DateTime? timestamp,
    ProductStatus? productStatus,
  }) {
    return AddProductState(
      coverImages: coverImages ?? this.coverImages,
      coverImagesAsByte: coverImagesAsByte ?? this.coverImagesAsByte,
      thumbnailImage: thumbnailImage ?? this.thumbnailImage,
      thumbnailImageAsByte: thumbnailImageAsByte ?? this.thumbnailImageAsByte,
      timestamp: timestamp ?? this.timestamp,
      productStatus: productStatus ?? this.productStatus,
    );
  }
}
