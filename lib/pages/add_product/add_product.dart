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
        return Scaffold(
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Product you want to sell💲",
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Details",
                        style: const TextStyle(fontStyle: FontStyle.italic),
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
                            TextField(
                                controller: titleController, hintText: "Title"),
                            const SizedBox(height: 20),
                            TextField(
                                controller: skuController, hintText: "Sku"),
                            const SizedBox(height: 20),
                            TextField(
                                controller: longDescriptionController,
                                hintText: "Long Description"),
                            const SizedBox(height: 20),
                            TextField(
                                controller: shortDescriptionController,
                                hintText: "Short Description"),
                            const SizedBox(height: 20),
                            TextField(
                                controller: priceController,
                                hintText: "Price",
                                keyboardType: TextInputType.number),
                            const SizedBox(height: 20),
                            TextField(
                                controller: quantityController,
                                hintText: "Initial Quantity",
                                keyboardType: TextInputType.number),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Images",
                        style: const TextStyle(fontStyle: FontStyle.italic),
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
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
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
                                  final file = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                },
                                child: Text('Pick Images')),
                            const SizedBox(height: 5),
                            const Text(
                              "Thumbnail (Max of 1)",
                              style:
                                  const TextStyle(fontStyle: FontStyle.italic),
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
                                  final file = await ImagePicker()
                                      .pickImage(source: ImageSource.gallery);
                                },
                                child: Text('Pick Image')),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class TextField extends StatelessWidget {
  const TextField({
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
