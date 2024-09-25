import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopella_store_app/models/cart_model.dart';
import 'package:shopella_store_app/screens/product_screen.dart';

class CartScreen extends StatelessWidget {
  static String id = 'Cart Screen';
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            'Shopping Cart',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26
          ),
        ),
      ),
      body: cart.cartItems.isEmpty
          ? const Center(
        child: Text(
        'Your Cart is Empty.',
        style: TextStyle(
          fontSize: 22,
        ),
      ),
      )
          : ListView.builder(
        itemCount: cart.cartItems.length,
        itemBuilder: (context, index) {
          final product = cart.cartItems[index];
          return InkWell(
            onTap: (){
              Navigator.pushNamed(context, ProductScreen.id, arguments: product);
            },
            child: ListTile(
              leading: Image.network(product.image),
              title: Text(product.title),
              subtitle: Text('${product.price.toStringAsFixed(2)} \$'),
              trailing: IconButton(
                icon: const Icon(
                  Icons.remove_circle,
                  size: 32,
                  color: Colors.red,
                ),
                onPressed: () => cart.removeFromCart(product),
              ),
            ),
          );
        },
      ),
    );
  }
}