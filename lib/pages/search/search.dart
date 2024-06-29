import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/pages/add_product/add_product.dart';
import 'package:kuicbuy/pages/home/product_list.dart';
import 'package:kuicbuy/pages/search/bloc/search_bloc.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(120), // Set this height
            child: Container(
              height: 70,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: CustomTextField(
                  textInputAction: TextInputAction.search,
                  onFieldSubmitted: (p0) {
                    context
                        .read<SearchBloc>()
                        .add(AlgoliaSearch(searchString: p0));
                  },
                  controller: searchController,
                  hintText: 'Search',
                ),
              ),
            ),
          ),
          body: state.algoliaStatus == AlgoliaStatus.idle
              ? MasonryGridView.count(
                  // shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  itemCount: state.products.length,
                  itemBuilder: (context, index) =>
                      ProductContainer(product: state.products[index]),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        );
      },
    );
  }
}
