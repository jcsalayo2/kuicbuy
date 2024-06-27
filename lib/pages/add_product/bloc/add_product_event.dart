part of 'add_product_bloc.dart';

abstract class AddProductEvent extends Equatable {
  const AddProductEvent();

  @override
  List<Object> get props => [];
}

class AddCoverImages extends AddProductEvent {
  final List<XFile> converImages;

  @override
  List<Object> get props => [];

  const AddCoverImages({required this.converImages});
}

class AddThumbnail extends AddProductEvent {
  final XFile thumbnailImage;

  @override
  List<Object> get props => [];

  const AddThumbnail({required this.thumbnailImage});
}

class CreateProduct extends AddProductEvent {
  final String title;
  final String sku;
  final String shortDescription;
  final String longDescription;
  final double price;
  final int initialQuantity;

  @override
  List<Object> get props => [];

  const CreateProduct({
    required this.title,
    required this.sku,
    required this.shortDescription,
    required this.longDescription,
    required this.price,
    required this.initialQuantity,
  });
}
