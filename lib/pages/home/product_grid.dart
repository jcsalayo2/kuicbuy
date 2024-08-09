import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:kuicbuy/bloc/main_bloc.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/pages/home/bloc/product_list_bloc.dart';
import 'package:kuicbuy/pages/product_details/product_details.dart';
import 'package:shimmer/shimmer.dart';

class ProductGrid extends StatefulWidget {
  const ProductGrid({super.key});

  @override
  State<ProductGrid> createState() => _ProductGridState();
}

class _ProductGridState extends State<ProductGrid> {
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

class ProductContainer extends StatelessWidget {
  const ProductContainer({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.indigo[50],
      child: InkWell(
        onTap: () {
          context
              .read<MainBloc>()
              .add(const ChangeNavBarSettings(isVisible: false));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetails(product: product),
            ),
          );
        },
        child: Column(
          children: [
            ProductImage(
              height: 150,
              width: double.infinity,
              image: product.images.thumbnail,
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.title,
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
                      product.description.short,
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
                      "₱${oCcy.format(product.price)}",
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

class ProductImage extends StatelessWidget {
  const ProductImage({
    super.key,
    required this.image,
    required this.height,
    required this.width,
  });

  final String image;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      height: height,
      width: width,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return SizedBox(
          height: height,
          width: width,
          child: const Center(child: CircularProgressIndicator()),
        );
        // return Center(
        //   child: Shimmer.fromColors(
        //     period: Duration(seconds: 1),
        //     baseColor: Colors.blue[50]!,
        //     highlightColor: Colors.blue[400]!,
        //     enabled: true,
        //     child: shimmerCard(
        //       context: context,
        //       height: 150,
        //     ),
        //   ),
        // );
      },
      image,
      fit: BoxFit.cover,
    );
  }
}
