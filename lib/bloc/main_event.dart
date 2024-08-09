part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent();

  @override
  List<Object> get props => [];
}

class ChangeNavBarSettings extends MainEvent {
  final bool? isVisible;
  final int? index;

  const ChangeNavBarSettings({
    this.isVisible,
    this.index,
  });
}

class GetSaved extends MainEvent {
  final String uid;

  const GetSaved({required this.uid});
}

class GetProductSaved extends MainEvent {
  final List<String> saved;

  const GetProductSaved({required this.saved});
}
