part of 'search_bloc.dart';

class SearchState extends Equatable {
  final AlgoliaStatus algoliaStatus;
  final List<Product> products;
  final int algoliaPage;
  final bool isLastPage;
  final String searchString;

  const SearchState({
    required this.algoliaStatus,
    required this.products,
    required this.algoliaPage,
    required this.isLastPage,
    required this.searchString,
  });

  @override
  List<Object> get props => [
        algoliaStatus,
        products,
        algoliaPage,
        isLastPage,
        searchString,
      ];

  SearchState.initial()
      : algoliaStatus = AlgoliaStatus.idle,
        products = [],
        algoliaPage = 0,
        isLastPage = false,
        searchString = '';

  SearchState copyWith({
    AlgoliaStatus? algoliaStatus,
    List<Product>? products,
    int? algoliaPage,
    bool? isLastPage,
    String? searchString,
  }) {
    return SearchState(
      algoliaStatus: algoliaStatus ?? this.algoliaStatus,
      products: products ?? this.products,
      algoliaPage: algoliaPage ?? this.algoliaPage,
      isLastPage: isLastPage ?? this.isLastPage,
      searchString: searchString ?? this.searchString,
    );
  }
}
