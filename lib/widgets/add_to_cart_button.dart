import 'package:flutter/material.dart';
import 'package:shopella_store_app/models/cart_model.dart';
import 'package:shopella_store_app/models/product_model.dart';
import 'package:provider/provider.dart'; // Import provider

class AddToCartButton extends StatelessWidget {
  const AddToCartButton({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context); // Access CartModel

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Container(
        width: 110,
        height: 40,
        decoration: BoxDecoration(
          color: cart.containsProduct(product) ? Colors.green : Colors.red, //Change color if added
          borderRadius: BorderRadius.circular(10),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: cart.containsProduct(product) ? Colors.green : Colors.red), //Change color if added
          onPressed: () {
            if(cart.containsProduct(product)){
              cart.removeFromCart(product);
            } else {
              cart.addToCart(product);
            }
          },
          child: Text(
            cart.containsProduct(product) ? 'Added to Cart' : 'Add to Cart',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9,
            ),
          ),
        ),
      ),
    );
  }
}