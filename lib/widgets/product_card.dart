import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopella_store_app/models/product_model.dart';
import 'package:shopella_store_app/screens/product_screen.dart';
import 'package:shopella_store_app/widgets/add_to_cart_button.dart';

import '../models/favorites_model.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoritesModel>(context);

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ProductScreen.id, arguments: productModel);
      },
      child: Stack(clipBehavior: Clip.none, children: [
        Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                blurRadius: 50,
                spreadRadius: 20,
                color: Colors.grey.withOpacity(0.2),
                offset: const Offset(10, 10),
              ),
            ],
          ),
          child: Card(
            elevation: 10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    productModel.title,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    '${productModel.price}' r' $',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    AddToCartButton(
                      product: productModel,
                    ),
                    IconButton(
                      onPressed: () {
                        favorites.toggleFavorite(productModel);
                      },
                      icon: Icon(
                        favorites.isFavorite(productModel.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Positioned(
          right: 35,
          bottom: 115,
          child: CachedNetworkImage(
            imageUrl: productModel.image,
            height: 105,
            width: 105,
          ),
        ),
      ]),
    );
  }
}
