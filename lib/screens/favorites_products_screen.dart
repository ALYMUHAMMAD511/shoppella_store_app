import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopella_store_app/models/favorites_model.dart';
import 'package:shopella_store_app/models/product_model.dart';
import 'package:shopella_store_app/screens/product_screen.dart';
import 'package:shopella_store_app/services/get_all_products_service.dart';


class FavoritesProductsScreen extends StatelessWidget {
  static String id = 'Favorites Screen';
  const FavoritesProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesModel>(context);
    return FutureBuilder<List<ProductModel>>(
      future: GetAllProductsService().getAllProducts(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final favoriteProducts = favorites.getFavoriteProducts(snapshot.data!);
          return Scaffold(
            appBar: AppBar(title: const Text(
              'Favorites',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            ),
            body: favoriteProducts.isEmpty
                ? const Center(child: Text(
              'No Favorites yet.',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            )
                : ListView.builder(
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, ProductScreen.id, arguments: product);
                  },
                  child: ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product.image,
                      height: 85,
                      width: 85,
                      fit: BoxFit.fill,
                    ),
                    title: Text(product.title),
                    subtitle: Text('${product.price.toStringAsFixed(2)} \$'),
                    trailing: IconButton(
                      onPressed: () {
                        favorites.toggleFavorite(product);
                      },
                      icon: Icon(
                        favorites.isFavorite(product.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                        size: 32,
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator(
            backgroundColor: Colors.red,
            color: Colors.white,
          ));
        }
      },
    );
  }
}