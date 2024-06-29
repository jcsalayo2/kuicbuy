import 'package:flutter/material.dart';
import 'package:kuicbuy/pages/add_product/add_product.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    var searchController = TextEditingController();
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextField(
              controller: searchController,
              hintText: 'Search',
            )
          ],
        ),
      ),
    );
  }
}
