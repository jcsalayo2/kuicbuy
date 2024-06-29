import 'package:algolia_helper_flutter/algolia_helper_flutter.dart';
import 'package:kuicbuy/models/product_model.dart';

class ProductHits {
  const ProductHits(
      this.items, this.pageKey, this.nextPageKey, this.isLastPage);

  final List<Product> items;
  final int pageKey;
  final int? nextPageKey;
  final bool isLastPage;

  factory ProductHits.fromResponse(SearchResponse response) {
    final items = response.hits.map(Product.fromJson).toList();
    final isLastPage = response.page >= response.nbPages;
    final nextPageKey = isLastPage ? null : response.page + 1;
    return ProductHits(items, response.page, nextPageKey, isLastPage);
  }
}
