import 'package:flutter/material.dart';
import '../models/product_model.dart';
import '../services/get_product_by_category_service.dart';
import '../widgets/product_card.dart';

class WomenClothingScreen extends StatefulWidget {
  const WomenClothingScreen({super.key, required this.searchQuery});

  static String id = 'Women Clothing Screen';
  final String searchQuery; // Accept search query from HomeScreen

  @override
  State<WomenClothingScreen> createState() => _WomenClothingScreenState();
}

class _WomenClothingScreenState extends State<WomenClothingScreen> {
  List<ProductModel> allProducts = [];  // Stores all products
  List<ProductModel> filteredProducts = [];  // Stores filtered products
  bool isLoading = true;  // Loading state

  @override
  void initState() {
    super.initState();
    fetchProducts();  // Fetch products when screen initializes
  }

  // Function to fetch products by category
  Future<void> fetchProducts() async {
    try {
      List<ProductModel> products = await GetProductByCategoryService().getProductsByCategory(categoryName: 'women\'s clothing');
      setState(() {
        allProducts = products;
        filteredProducts = products;  // Initially, display all products
        isLoading = false;  // Loading completed
      });
    } catch (error) {
      setState(() {
        isLoading = false;  // Stop loading on error
      });
    }
  }

  // Function to filter products based on the search query
  void searchProducts(String query) {
    final results = allProducts.where((product) {
      final productTitle = product.title.toLowerCase();
      final input = query.toLowerCase();
      return productTitle.contains(input);  // Check if product title contains the query
    }).toList();

    setState(() {
      filteredProducts = results;  // Update the filtered list of products
    });
  }

  @override
  Widget build(BuildContext context) {
    // Call search function with the search query from HomeScreen
    searchProducts(widget.searchQuery);

    return isLoading
        ? const Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.red,
        color: Colors.white,
      ),
    )
        : filteredProducts.isEmpty
        ? const Center(child: Text('No products found'))
        : Padding(
      padding: const EdgeInsets.only(
        top: 30,
        left: 16,
        right: 16,
      ),
      child: GridView.builder(
        padding: const EdgeInsets.only(top: 60),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.15,
          crossAxisSpacing: 10,
          mainAxisSpacing: 85,
        ),
        itemBuilder: (context, index) => ProductCard(productModel: filteredProducts[index]),
        itemCount: filteredProducts.length,
        clipBehavior: Clip.hardEdge,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
