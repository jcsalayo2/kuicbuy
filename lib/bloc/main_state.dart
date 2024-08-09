part of 'main_bloc.dart';

class MainState extends Equatable {
  final bool isVisible;
  final PersistentTabController controller;
  final List<String> saved;
  final List<Product> savedProducts;

  const MainState({
    required this.isVisible,
    required this.controller,
    required this.saved,
    required this.savedProducts,
  });

  MainState.initial()
      : isVisible = true,
        controller = PersistentTabController(initialIndex: 0),
        saved = [],
        savedProducts = [];

  @override
  List<Object> get props => [
        isVisible,
        controller,
        saved,
        savedProducts,
      ];

  MainState copyWith({
    bool? isVisible,
    PersistentTabController? controller,
    List<String>? saved,
    List<Product>? savedProducts,
  }) {
    return MainState(
      isVisible: isVisible ?? this.isVisible,
      controller: controller ?? this.controller,
      saved: saved ?? this.saved,
      savedProducts: savedProducts ?? this.savedProducts,
    );
  }
}
