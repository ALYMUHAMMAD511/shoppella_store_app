// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../helper/show_snack_bar.dart';
import '../services/add_product_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  static String id = 'Add Product Screen';

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  String? productTitle;
  String? description;
  String? category;
  String? image;
  String? price;
  bool isLoading = false;

  Future<void> addProduct() async {
    try {
      await AddProductService().addProduct(
        title: productTitle!,
        description: description!,
        price: price!,
        image: image!,
        category: category!,
      );
      showSnackBar(context, 'Product Added Successfully', Colors.green);
    } catch (e) {
      showSnackBar(context, 'Failed to add product: $e', Colors.red);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      progressIndicator: const Center(child: CircularProgressIndicator(
        color: Colors.white,
        backgroundColor: Colors.red,
      )),
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Add Product',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const SizedBox(height: 30),
                CustomTextField(
                  hint: 'Title',
                  onChanged: (value) {
                    productTitle = value;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Description',
                  onChanged: (value) {
                    description = value;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Category',
                  onChanged: (value) {
                    category = value;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  inputType: TextInputType.number,
                  hint: 'Price',
                  onChanged: (value) {
                    price = value;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Image',
                  onChanged: (value) {
                    image = value;
                  },
                ),
                const SizedBox(height: 40),
                CustomButton(
                  text: 'Add Product',
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await addProduct();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
