import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:shopella_store_app/screens/add_product_screen.dart';
import 'package:shopella_store_app/screens/cart_screen.dart';
import 'package:shopella_store_app/screens/electronics_screen.dart';
import 'package:shopella_store_app/screens/favorites_products_screen.dart';
import 'package:shopella_store_app/screens/jewelery_screen.dart';
import 'package:shopella_store_app/screens/men_clothing_screen.dart';
import 'package:shopella_store_app/screens/women_clothing_screen.dart';
import 'package:shopella_store_app/widgets/custom_app_bar_title.dart';
import 'all_products_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String id = 'Home Screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  int currentIndex = 0;
  List<Widget> screens =
  [
    const AllProductsScreen(),
    ElectronicsScreen(),
    JeweleryScreen(),
    MenClothingScreen(),
    WomenClothingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()
          {
            Navigator.pushNamed(context, AddProductScreen.id);
          },
          icon: Image.asset(
            'assets/images/add-product.png',
            height: 30,
            width: 30,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        title: const CustomAppBarTitle(),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, CartScreen.id);
            },
            icon: const Icon(
              FontAwesomeIcons.cartShopping,
              color: Colors.black,
              size: 24,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, FavoritesProductsScreen.id);
            },
            icon: const Icon(
              Icons.favorite,
              size: 30,
              color: Colors.red,
            ),
          ),
        ],
      ),
      body: screens[currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black,
        currentIndex: currentIndex,
        onTap: (int index)
        {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.house),
            title: const Text(
              'Home',
              style: TextStyle(
                fontSize: 9.5,
              ),
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.laptop),
            title: const Text(
              'Electronics',
              style: TextStyle(
                fontSize: 9.5,
              ),
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.solidGem),
            title: const Text(
              'Jewelery',
              style: TextStyle(
                fontSize: 9.5,
              ),
            ),
          ),
          SalomonBottomBarItem(
            icon: const Icon(FontAwesomeIcons.shirt),
            title: const Text(
              'Men\'s Clothing',
              style: TextStyle(
                fontSize: 9.5,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
                'assets/images/dress_icon.svg',
              height: 22,
              width: 22,
            ),
            title: const Text(
              'Women\'s Clothing',
              style: TextStyle(
                fontSize: 9,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}