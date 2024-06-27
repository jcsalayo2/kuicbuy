part of 'productdetails_bloc.dart';

abstract class ProductdetailsEvent extends Equatable {
  const ProductdetailsEvent();

  @override
  List<Object> get props => [];
}

class CompileAllImages extends ProductdetailsEvent {
  final Images images;
  @override
  List<Object> get props => [];

  const CompileAllImages({
    required this.images,
  });
}

class SetSelectedImageIndex extends ProductdetailsEvent {
  final int index;
  @override
  List<Object> get props => [];

  const SetSelectedImageIndex({
    required this.index,
  });
}
