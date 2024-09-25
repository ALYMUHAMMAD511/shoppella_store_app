import 'package:flutter/material.dart';
import 'package:shopella_store_app/models/product_model.dart';

class CartModel with ChangeNotifier {
  List<ProductModel> cartItems = [];

  List<ProductModel> get cart => cartItems;

  void addToCart(ProductModel product) {
    cartItems.add(product);
    notifyListeners(); // Notify listeners of changes
  }

  void removeFromCart(ProductModel product) {
    cartItems.remove(product);
    notifyListeners();
  }

  bool containsProduct(ProductModel product){
    return cartItems.contains(product);
  }
}