import 'package:flutter/material.dart';
import 'package:shopella_store_app/models/product_model.dart';
import '../services/get_product_by_category_service.dart';
import '../widgets/product_card.dart';

// ignore: must_be_immutable
class ElectronicsScreen extends StatelessWidget {
  ElectronicsScreen({super.key});

  static String id = 'Electronics Screen';
  String category = 'electronics';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 80,
        left: 16,
        right: 16,
      ),
      child: FutureBuilder<List<ProductModel>>(
        future: GetProductByCategoryService().getProductsByCategory(categoryName: category),
        builder: (context, snapshot)
        {
          if (snapshot.hasData)
          {
            List<ProductModel> products = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.15,
                crossAxisSpacing: 10,
                mainAxisSpacing: 85,
              ),
              itemBuilder: (context, index) => ProductCard(productModel: products[index],),
              itemCount: products.length,
              clipBehavior: Clip.none,
            );
          }
          else
          {
            return const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                color: Colors.white,
              ),
            );
          }
        },
      ),
    );
  }
}