import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopella_store_app/screens/add_product_screen.dart';
import 'package:shopella_store_app/screens/all_products_screen.dart';
import 'package:shopella_store_app/screens/cart_screen.dart';
import 'package:shopella_store_app/screens/electronics_screen.dart';
import 'package:shopella_store_app/screens/favorites_products_screen.dart';
import 'package:shopella_store_app/screens/home_screen.dart';
import 'package:shopella_store_app/screens/jewelery_screen.dart';
import 'package:shopella_store_app/screens/product_screen.dart';
import 'package:shopella_store_app/screens/update_product_screen.dart';
import 'models/cart_model.dart';
import 'models/favorites_model.dart';
import 'screens/men_clothing_screen.dart';
import 'screens/women_clothing_screen.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CartModel()),
      ChangeNotifierProvider(create: (context) => FavoritesModel()),
    ],
    child: const ShoppellaStoreApp(),
  ));
}

class ShoppellaStoreApp extends StatelessWidget {
  const ShoppellaStoreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: HomeScreen.id,
      routes: {
        HomeScreen.id: (context) => const HomeScreen(),
        AllProductsScreen.id: (context) => const AllProductsScreen(),
        ProductScreen.id: (context) => const ProductScreen(),
        CartScreen.id: (context) => const CartScreen(),
        FavoritesProductsScreen.id: (context) => const FavoritesProductsScreen(),
        UpdateProductScreen.id: (context) => const UpdateProductScreen(),
        AddProductScreen.id: (context) => const AddProductScreen(),
        ElectronicsScreen.id: (context) => ElectronicsScreen(),
        JeweleryScreen.id: (context) => JeweleryScreen(),
        MenClothingScreen.id: (context) => MenClothingScreen(),
        WomenClothingScreen.id: (context) => WomenClothingScreen(),
      },
    );
  }
}
