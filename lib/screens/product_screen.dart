import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:shopella_store_app/models/favorites_model.dart';
import 'package:shopella_store_app/models/product_model.dart';
import 'package:shopella_store_app/screens/update_product_screen.dart';
import 'package:shopella_store_app/widgets/custom_button.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shopella_store_app/widgets/add_to_cart_button.dart';
import '../services/get_all_products_service.dart';

class ProductScreen extends StatefulWidget {
  static const String id = 'ProductScreen';

  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final CarouselSliderController _controller = CarouselSliderController();
  int _currentIndex = 0;
  late Future<List<ProductModel>> productsFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the product fetching
    productsFuture = GetAllProductsService().getAllProducts();
  }

// Call this function when the product is updated
  void refreshProducts() {
    setState(() {
      productsFuture = GetAllProductsService().getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    final product = ModalRoute.of(context)?.settings.arguments as ProductModel;
    final favorites = Provider.of<FavoritesModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              carouselController: _controller,
              items: [
                for (var image in [product.image])
                  CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    fit: BoxFit.contain,
                    height: 300,
                    width: double.infinity,
                  ),
              ],
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
            ),
            Center(
              child: AnimatedSmoothIndicator(
                activeIndex: _currentIndex,
                count: 1,
                effect: const WormEffect(
                  activeDotColor: Colors.red,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  RatingBar.builder(
                    initialRating: product.rating!.rate,
                    minRating: 0,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: 8),
                  Text(
                      'Rating: ${product.rating!.rate} (${product.rating!.count} reviews)'),
                  const SizedBox(height: 8),
                  Text(
                    '${product.price.toStringAsFixed(2)} \$',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(product.description),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
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
                      AddToCartButton(product: product),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomButton(
                      text: 'Update Product',
                      onPressed: ()
                      {
                        Navigator.pushNamed(context, UpdateProductScreen.id, arguments: product)
                            .then((updated) {
                          if (updated != null && updated == true) {
                            refreshProducts(); // refresh product list after update
                          }
                        });
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
