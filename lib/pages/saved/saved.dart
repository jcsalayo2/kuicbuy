import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/bloc/main_bloc.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/pages/home/product_grid.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.savedProducts.length,
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            return savedProductTile(product: state.savedProducts[index]);
          },
        );
      },
    );
  }

  Widget savedProductTile({required Product product}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[200],
      ),
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      padding: const EdgeInsets.all(8),
      height: 128,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: ProductImage(
              height: double.infinity,
              width: 112,
              image: product.images.thumbnail,
            ),
          ),
        ],
      ),
    );
  }
}
