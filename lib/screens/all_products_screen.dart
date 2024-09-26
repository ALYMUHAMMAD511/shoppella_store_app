import 'package:flutter/material.dart';
import 'package:shopella_store_app/models/product_model.dart';
import '../widgets/product_card.dart';

class AllProductsScreen extends StatelessWidget {
  final List<ProductModel> products;
  final String searchQuery; // Add search query parameter

  const AllProductsScreen({required this.products, required this.searchQuery, super.key});

  static String id = 'Products Screen';

  @override
  Widget build(BuildContext context) {
    // Filter products based on search query
    final filteredProducts = products.where((product) {
      final productTitle = product.title.toLowerCase();
      final input = searchQuery.toLowerCase();
      return productTitle.contains(input);
    }).toList();

    if (filteredProducts.isEmpty) {
      return const Center(
        child: Text('No products found'),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 16, right: 16),
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 40),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.08,
          crossAxisSpacing: 10,
          mainAxisSpacing: 80,
        ),
        itemBuilder: (context, index) => ProductCard(
          productModel: filteredProducts[index],
        ),
        itemCount: filteredProducts.length,
        clipBehavior: Clip.hardEdge,
        physics: const AlwaysScrollableScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
