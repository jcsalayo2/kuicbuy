// ignore_for_file: use_build_context_synchronously

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kuicbuy/constants/constant.dart';
import 'package:kuicbuy/pages/add_product/bloc/add_product_bloc.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var titleController = TextEditingController();
  var skuController = TextEditingController();
  var longDescriptionController = TextEditingController();
  var shortDescriptionController = TextEditingController();
  var priceController = TextEditingController();
  var quantityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddProductBloc(),
      child: Builder(builder: (context) {
        return BlocConsumer<AddProductBloc, AddProductState>(
            listener: (context, state) {
          if (state.productStatus == ProductStatus.done) {
            Navigator.pop(context);
          } else if (state.productStatus == ProductStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
              ),
            );
          }
        }, builder: (context, state) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 20),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20, top: 10, right: 20, bottom: 10),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.arrow_back_ios_new),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Product you want to sell💲",
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Details",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 5),
                        DottedBorder(
                          customPath: (size) {
                            return roundedDottedBorder(size);
                          },
                          dashPattern: const [10, 5],
                          strokeWidth: 1,
                          color: Colors.black,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              CustomTextField(
                                  controller: titleController,
                                  hintText: "Title"),
                              const SizedBox(height: 20),
                              CustomTextField(
                                  controller: skuController, hintText: "Sku"),
                              const SizedBox(height: 20),
                              CustomTextField(
                                  controller: longDescriptionController,
                                  hintText: "Long Description"),
                              const SizedBox(height: 20),
                              CustomTextField(
                                  controller: shortDescriptionController,
                                  hintText: "Short Description"),
                              const SizedBox(height: 20),
                              CustomTextField(
                                  controller: priceController,
                                  hintText: "Price",
                                  keyboardType: TextInputType.number),
                              const SizedBox(height: 20),
                              CustomTextField(
                                  controller: quantityController,
                                  hintText: "Initial Quantity",
                                  keyboardType: TextInputType.number),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          "Images",
                          style: TextStyle(fontStyle: FontStyle.italic),
                        ),
                        const SizedBox(height: 5),
                        DottedBorder(
                          customPath: (size) {
                            return roundedDottedBorder(size);
                          },
                          dashPattern: const [10, 5],
                          strokeWidth: 1,
                          color: Colors.black,
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Cover (Max of 3)",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.blue),
                                  onPressed: () async {
                                    var files = await ImagePicker()
                                        .pickMultiImage(limit: 3);

                                    if (files.isEmpty) {
                                      return;
                                    } else if (files.length > 3) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        content: Text(
                                            "You can only choose 3 images"),
                                      ));
                                      return;
                                    }

                                    context.read<AddProductBloc>().add(
                                        AddCoverImages(converImages: files));
                                  },
                                  child: const Text('Pick Images')),
                              const SizedBox(height: 5),
                              if (state.coverImagesAsByte.isNotEmpty)
                                GridView.builder(
                                    shrinkWrap: true,
                                    itemCount: state.coverImages.length,
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 3),
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Image.memory(
                                        state.coverImagesAsByte[index],
                                        fit: BoxFit.contain,
                                      );
                                    }),
                              const SizedBox(height: 10),
                              const Text(
                                "Thumbnail (Max of 1)",
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                              TextButton(
                                  style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      padding: const EdgeInsets.only(
                                          top: 20, bottom: 20),
                                      foregroundColor: Colors.white,
                                      backgroundColor: Colors.blue),
                                  onPressed: () async {
                                    var file = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);

                                    if (file == null) {
                                      return;
                                    }

                                    context
                                        .read<AddProductBloc>()
                                        .add(AddThumbnail(
                                          thumbnailImage: file,
                                        ));
                                  },
                                  child: const Text('Pick Image')),
                              const SizedBox(height: 5),
                              if (state.thumbnailImageAsByte != null)
                                Image.memory(
                                  height: 125,
                                  state.thumbnailImageAsByte!,
                                  fit: BoxFit.contain,
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue),
                      onPressed: state.productStatus == ProductStatus.initial
                          ? () {
                              if (titleController.text.trim().isEmpty ||
                                  skuController.text.trim().isEmpty ||
                                  shortDescriptionController.text
                                      .trim()
                                      .isEmpty ||
                                  longDescriptionController.text
                                      .trim()
                                      .isEmpty ||
                                  priceController.text.trim().isEmpty ||
                                  quantityController.text.trim().isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Please fill all the fields'),
                                ));
                                return;
                              }
                              if (state.coverImages.isEmpty ||
                                  state.thumbnailImage == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text(
                                      'Please add cover images and thumbnail image'),
                                ));
                                return;
                              }
                              if (double.tryParse(priceController.text) ==
                                  null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content: Text('Please enter a valid price'),
                                ));
                              }
                              if (double.tryParse(quantityController.text) ==
                                  null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(const SnackBar(
                                  content:
                                      Text('Please enter a valid quantity'),
                                ));
                              }
                              context.read<AddProductBloc>().add(CreateProduct(
                                    title: titleController.text,
                                    sku: skuController.text,
                                    shortDescription:
                                        shortDescriptionController.text,
                                    longDescription:
                                        longDescriptionController.text,
                                    price: double.parse(priceController.text),
                                    initialQuantity:
                                        int.parse(quantityController.text),
                                  ));
                            }
                          : null,
                      child: state.productStatus == ProductStatus.initial
                          ? const Text(
                              "Submit",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          : const CircularProgressIndicator(
                              color: Colors.white,
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      }),
    );
  }
}

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
  });

  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: () {
          switch (hintText) {}
        }(),
        filled: true,
        fillColor: const Color.fromARGB(255, 233, 233, 233),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            borderSide: BorderSide(color: Colors.green)),
        hintText: hintText,
      ),
      style: const TextStyle(
        fontSize: 18,
      ),
    );
  }
}
