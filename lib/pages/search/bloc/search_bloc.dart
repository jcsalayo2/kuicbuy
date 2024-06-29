import 'dart:async';

import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/core/boot/environment.dart';
import 'package:kuicbuy/models/algolia/productHits.dart';
import 'package:kuicbuy/models/product_model.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final hitsSearcher = HitsSearcher(
    applicationID: Environment.instance.algoliaApplicationID,
    apiKey: Environment.instance.algoliaApiKey,
    indexName: Environment.instance.algoliaIndexName,
  );

  Stream<ProductHits> get searchResult =>
      hitsSearcher.responses.map(ProductHits.fromResponse);

  final String test = "restsetes";

  SearchBloc() : super(SearchState.initial()) {
    on<SearchEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<AlgoliaSearch>(_algoliaSearch);
  }

  FutureOr<void> _algoliaSearch(
      AlgoliaSearch event, Emitter<SearchState> emit) async {
    emit(state.copyWith(
      products: [],
      algoliaStatus: AlgoliaStatus.loading,
      algoliaPage: 0,
      isLastPage: false,
    ));

    // Detect if the same query from last
    if (state.searchString == event.searchString && state.algoliaPage == 0) {
      hitsSearcher.rerun();
    } else {
      hitsSearcher.applyState((state) {
        return state.copyWith(
          query: event.searchString,
          page: this.state.algoliaPage,
        );
      });
    }

    // Get the result from latest query
    await searchResult.first.then((value) {
      state.products.addAll(value.items);
      emit(state.copyWith(
        searchString: event.searchString,
        algoliaPage: value.pageKey,
        isLastPage: value.isLastPage,
        products: state.products,
        algoliaStatus: AlgoliaStatus.idle,
      ));
    });
  }
}
