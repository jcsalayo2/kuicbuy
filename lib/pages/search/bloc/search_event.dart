part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class AlgoliaSearch extends SearchEvent {
  final String searchString;

  @override
  List<Object> get props => [];

  const AlgoliaSearch({
    required this.searchString,
  });
}
