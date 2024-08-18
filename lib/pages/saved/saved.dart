import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/bloc/main_bloc.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/grouped_saved_products.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/pages/home/product_grid.dart';
import 'package:kuicbuy/pages/product_details/bloc/productdetails_bloc.dart';
import 'package:kuicbuy/pages/product_details/product_details.dart';

class Saved extends StatefulWidget {
  const Saved({super.key});

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.groupSavedProducts.length,
          padding: const EdgeInsets.only(left: 16, right: 16),
          itemBuilder: (context, index) {
            return savedProductGroupBySeller(
                groupSavedProducts: state.groupSavedProducts[index]);
          },
        );
      },
    );
  }

  Widget savedProductGroupBySeller(
      {required GroupedSavedProducts groupSavedProducts}) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      child: Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text(groupSavedProducts.seller.fullName)),
          ListView.builder(
              itemCount: groupSavedProducts.products.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return savedProductTile(
                    product: groupSavedProducts.products[index]);
              })
        ],
      ),
    );
  }

  Widget savedProductTile({required Product product}) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.blue[100],
      ),
      margin: const EdgeInsets.only(bottom: 8, top: 8),
      padding: const EdgeInsets.all(8),
      height: 128,
      child: Row(
        children: [
          productImage(product),
          const SizedBox(
            width: 8,
          ),
          Flexible(
            fit: FlexFit.tight,
            child: productDetails(product),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  context.read<MainBloc>().add(RemoveSaved(
                        uid: auth.currentUser?.uid ?? '',
                        productId: product.id,
                      ));
                },
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.delete,
                    color: Colors.red[300],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<MainBloc>().add(StartChat(
                        uid: auth.currentUser?.uid ?? '',
                        product: product,
                      ));
                },
                child: const SizedBox(
                  width: 50,
                  height: 50,
                  child: Icon(
                    Icons.message,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Column productDetails(Product product) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          product.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 18, color: Colors.black),
        ),
        Text(
          product.description.short,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12, color: Colors.black),
        ),
        const Spacer(
          flex: 1,
        ),
        Text(
          style: TextStyle(
            color: Colors.indigo[900],
            fontWeight: FontWeight.bold,
          ),
          "₱${oCcy.format(product.price)}",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget productImage(Product product) {
    return InkWell(
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
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: ProductImage(
          height: double.infinity,
          width: 112,
          image: product.images.thumbnail,
        ),
      ),
    );
  }
}
