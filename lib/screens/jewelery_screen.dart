import 'package:flutter/material.dart';
import 'package:shopella_store_app/models/product_model.dart';
import '../services/get_product_by_category_service.dart';
import '../widgets/product_card.dart';

class JeweleryScreen extends StatefulWidget {
  static String id = 'Jewelery Screen';
  final String searchQuery; // Add search query parameter

  const JeweleryScreen(
      {required this.searchQuery, super.key}); // Modify constructor

  @override
  State<JeweleryScreen> createState() => _JeweleryScreenState();
}

class _JeweleryScreenState extends State<JeweleryScreen> {
  String category = 'jewelery';
  List<ProductModel> allProducts = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      List<ProductModel> products = await GetProductByCategoryService()
          .getProductsByCategory(categoryName: category);
      setState(() {
        allProducts = products;
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filter products based on search query
    final filteredProducts = allProducts.where((product) {
      final productTitle = product.title.toLowerCase();
      final input = widget.searchQuery.toLowerCase(); // Use widget.searchQuery
      return productTitle.contains(input);
    }).toList();

    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
            color: Colors.white,
            backgroundColor: Colors.red,
          ),
      );
    } else if (filteredProducts.isEmpty) {
      return const Center(child: Text('No products found'));
    }

    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 16,
        right: 16,
      ),
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
