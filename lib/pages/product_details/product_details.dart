import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/pages/product_details/bloc/productdetails_bloc.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key, required this.product});

  final Product product;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductDetailsBloc()
        ..add(CompileAllImages(images: widget.product.images)),
      child: Builder(builder: (context) {
        return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            if (state.productDetailsStatus == ProductDetailsStatus.initial ||
                state.productDetailsStatus == ProductDetailsStatus.loading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            }
            return Scaffold(
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          height: 450,
                          state.images[state.selectedImageIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    GridView.builder(
                        padding:
                            const EdgeInsets.only(left: 20, right: 20, top: 15),
                        shrinkWrap: true,
                        itemCount: state.images.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 8, crossAxisCount: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              context
                                  .read<ProductDetailsBloc>()
                                  .add(SetSelectedImageIndex(index: index));
                            },
                            child: Ink(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: state.selectedImageIndex == index
                                    ? Border.all(
                                        color: Colors.blue,
                                        width: 2,
                                      )
                                    : null,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  state.images[index],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
