import 'package:flutter/material.dart';
import 'package:shopella_store_app/models/product_model.dart';

class FavoritesModel with ChangeNotifier {
  final Set<int> _favoriteProductIds = {}; // Use a Set for efficient lookup

  Set<int> get favoriteProductIds => _favoriteProductIds;

  bool isFavorite(int productId) {
    return _favoriteProductIds.contains(productId);
  }

  void toggleFavorite(ProductModel product) {
    if (_favoriteProductIds.contains(product.id)) {
      _favoriteProductIds.remove(product.id);
    } else {
      _favoriteProductIds.add(product.id);
    }
    notifyListeners();
  }

  List<ProductModel> getFavoriteProducts(List<ProductModel> allProducts){
    return allProducts.where((product) => _favoriteProductIds.contains(product.id)).toList();
  }
}