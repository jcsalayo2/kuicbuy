import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/models/product_model.dart';
import 'package:kuicbuy/pages/home/product_list.dart';
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
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 20, bottom: 20, right: 20),
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
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.network(
                          height: 450,
                          state.images[state.selectedImageIndex],
                          fit: BoxFit.cover,
                        ),
                      ),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(top: 15, bottom: 20),
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
                                child: ProductImage(
                                  image: state.images[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Text(
                        'PHP ₱${oCcy.format(widget.product.price)}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        widget.product.description.long,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 5,
                    ),
                  ],
                ),
                height: 40,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 2,
                      child: InkWell(
                        onTap: () {
                          context
                              .read<ProductDetailsBloc>()
                              .add(AskGemini(title: widget.product.title));

                          // showGeminiDialog(
                          //   context: context,
                          //   response: state.geminiResponse,
                          //   isLoading:
                          //       state.geminiStatus == GeminiStatus.loading,
                          // );

                          final productDetailsBloc =
                              context.read<ProductDetailsBloc>();

                          showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return GeminiDialog(
                                  productDetailsBloc: productDetailsBloc,
                                  product: widget.product);
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          margin: const EdgeInsets.all(3),
                          height: double.maxFinite,
                          width: double.maxFinite,
                          child: const Center(
                            child: Text(
                              'Ask Gemini AI',
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        margin: const EdgeInsets.all(3),
                        height: double.infinity,
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.add_shopping_cart_rounded,
                              size: 12,
                              color: Colors.white,
                            ),
                            Text(
                              'Add to Cart',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Container(
                        margin: const EdgeInsets.all(3),
                        height: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Buy Now',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                            Text(
                              '₱${oCcy.format(widget.product.price)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                                height: 1,
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
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

class GeminiDialog extends StatelessWidget {
  const GeminiDialog({
    super.key,
    required this.productDetailsBloc,
    required this.product,
  });

  final ProductDetailsBloc productDetailsBloc;
  final Product product;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductDetailsBloc>.value(
      value: productDetailsBloc,
      child: Builder(builder: (context) {
        return BlocBuilder<ProductDetailsBloc, ProductDetailsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Colors.blue[100],
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 35),
                child: state.geminiStatus == GeminiStatus.idle
                    ? Material(
                        color: Colors.blue[100],
                        child: SingleChildScrollView(
                          child: Text(
                            state.geminiResponse,
                            style: TextStyle(
                              fontVariations: fontWeight(size: 500),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      )
                    : Material(
                        color: Colors.blue[100],
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "What is ${product.title}? What are the uses of ${product.title}?",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontVariations: fontWeight(size: 500),
                                  fontSize: 16,
                                ),
                              ),
                              const SizedBox(
                                height: 30,
                              ),
                              const CircularProgressIndicator(
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Gemini is Thinking",
                                style: TextStyle(
                                  fontVariations: fontWeight(size: 300),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
              ),
            );
          },
        );
      }),
    );
  }
}
