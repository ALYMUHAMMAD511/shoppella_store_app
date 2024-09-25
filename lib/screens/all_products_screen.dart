import 'package:flutter/material.dart';
import 'package:shopella_store_app/models/product_model.dart';
import 'package:shopella_store_app/services/get_all_products_service.dart';
import '../widgets/product_card.dart';

class AllProductsScreen extends StatefulWidget {
  const AllProductsScreen({super.key});

  static String id = 'Products Screen';

  @override
  State<AllProductsScreen> createState() => _AllProductsScreenState();
}

class _AllProductsScreenState extends State<AllProductsScreen> {
  late Future<List<ProductModel>> _productsFuture;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  void _loadProducts() {
    _productsFuture = GetAllProductsService().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 80, left: 16, right: 16),
      child: FutureBuilder<List<ProductModel>>(
        future: _productsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                color: Colors.white,
              ),
            );
          }

          if (snapshot.hasData) {
            List<ProductModel> products = snapshot.data!;

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.08,
                crossAxisSpacing: 10,
                mainAxisSpacing: 80,
              ),
              itemBuilder: (context, index) => ProductCard(
                productModel: products[index],
              ),
              itemCount: products.length,
              clipBehavior: Clip.none,
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading products'));
          } else {
            return const Center(child: Text('No products found'));
          }
        },
      ),
    );
  }
}
