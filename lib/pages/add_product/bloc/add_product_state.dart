part of 'add_product_bloc.dart';

sealed class AddProductState extends Equatable {
  const AddProductState();
  
  @override
  List<Object> get props => [];
}

final class AddProductInitial extends AddProductState {}
