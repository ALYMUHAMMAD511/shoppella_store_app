// ignore_for_file: use_build_context_synchronously
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:shopella_store_app/helper/show_snack_bar.dart';
import '../models/product_model.dart';
import '../services/update_product_service.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key});

  static String id = 'Update Product Screen';

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  String? productTitle;
  String? description;
  String? category;
  String? image;
  String? price;
  bool isLoading = false;

  Future<void> updateProduct(ProductModel product) async {
    await UpdateProductService().updateProduct(
      id: product.id,
      title: productTitle == null ? product.title : productTitle!,
      description: description == null ? product.description : description!,
      price: price == null ? product.price.toString() : price!,
      image: image == null ? product.image : image!,
      category: product.category,
    );

    // Once updated, pop and refresh the product list
    Navigator.pop(context, true); // pass true to signal update
  }

  @override
  Widget build(BuildContext context) {
    ProductModel product =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Update Product',
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
                  text: 'Update Product',
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await updateProduct(product);
                      showSnackBar(
                        context,
                        'Product Updated Successfully',
                        Colors.green,
                      );

                      // Pop back and refresh the product list screen
                      Navigator.pop(context, true);
                    } catch (e) {
                      if (kDebugMode) {
                        print(e.toString());
                      }
                      showSnackBar(
                        context,
                        'There was an Error Updating the Product',
                        Colors.red,
                      );
                    }
                    setState(() {
                      isLoading = false;
                    });
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
