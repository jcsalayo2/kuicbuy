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

class AskGemini extends ProductdetailsEvent {
  final String title;
  @override
  List<Object> get props => [];

  const AskGemini({
    required this.title,
  });
}

class ToggleSaved extends ProductdetailsEvent {
  final bool isSaved;

  const ToggleSaved({
    required this.isSaved,
  });
}

class AddOrRemoveToSaved extends ProductdetailsEvent {
  final bool isSaved;
  final String id;
  final String uid;
  final MainBloc mainBloc;

  const AddOrRemoveToSaved({
    required this.isSaved,
    required this.id,
    required this.uid,
    required this.mainBloc,
  });
}

class ContactSeller extends ProductdetailsEvent {
  final String uid;
  final Product product;
  @override
  List<Object> get props => [];

  const ContactSeller({
    required this.uid,
    required this.product,
  });
}
