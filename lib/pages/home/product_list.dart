import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/pages/home/bloc/product_list_bloc.dart';
import 'package:kuicbuy/pages/product_details/product_details.dart';
import 'package:shimmer/shimmer.dart';

class ProductList extends StatefulWidget {
  const ProductList({super.key});

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductListBloc, ProductListState>(
      builder: (context, state) {
        return MasonryGridView.count(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          itemCount: state.products.length,
          itemBuilder: (context, index) =>
              ProductContainer(product: state.products[index]),
        );
      },
    );
  }
}

class ProductContainer extends StatefulWidget {
  const ProductContainer({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetails(product: widget.product),
          ),
        );
      },
      child: Ink(
        color: Colors.indigo[50],
        child: Column(
          children: [
            Image.network(
              height: 170,
              width: double.infinity,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: Shimmer.fromColors(
                    baseColor: const Color(0xff3290A3),
                    highlightColor: const Color(0xFF4DBFD6),
                    enabled: true,
                    child: shimmerCard(
                      context: context,
                      height: 150,
                    ),
                  ),
                );
              },
              widget.product.images.thumbnail,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.product.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.product.description.short,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      style: TextStyle(
                        color: Colors.indigo[900],
                        fontWeight: FontWeight.bold,
                      ),
                      "₱${oCcy.format(widget.product.price)}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
