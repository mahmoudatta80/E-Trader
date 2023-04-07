import 'package:e_commerce_app/modules/cart.dart';
import 'package:e_commerce_app/modules/categories.dart';
import 'package:e_commerce_app/modules/favourites.dart';
import 'package:e_commerce_app/modules/products.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:e_commerce_app/models/api_model/softagi.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeLayout extends StatefulWidget {
  int currentIndex;

  HomeLayout({Key? key, required this.currentIndex}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeLayout> {
  static Softagi? productModel;
  static Softagi? categoryModel;
  Map<int, bool> favourites = {};
  Map<int, bool> cart = {};
  bool end = false;

  Future<int> getData() async {
    return 2;
  }

  @override
  void initState() {
    setState(() {
      end = false;
    });
    super.initState();
    DioHelper.getProduct().then((value) {
      productModel = Softagi.fromJson(value.data);
    }).then((value) {
      for (var e in productModel!.data!.productModel) {
        favourites.addAll({
          e.id: false,
        });
        cart.addAll({
          e.id: false,
        });
      }
      setState(() {
        end = true;
      });
    });
    DioHelper.getCategory().then((value) {
      categoryModel = Softagi.fromJson(value.data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Search for product',
          style: TextStyle(
            color: Colors.indigo,
          ),
        ),
        leadingWidth: 0,
        actions: [
          IconButton(
            splashColor: Colors.white,
            highlightColor: Colors.white,
            hoverColor: Colors.white,
            focusColor: Colors.white,
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.indigo,
            ),
          ),
        ],
      ),
      body: FutureBuilder(
        future: DioHelper.getProduct(),
        builder: (context, snapshot) {
          if (productModel != null &&
              categoryModel != null &&
              end == true) {
            List<Widget> screens = [
              ProductsScreen(
                productModel: productModel!,
                categoryModel: categoryModel!,
                favourites: favourites,
                cart: cart,
              ),
              CategoriesScreen(categoryModel: categoryModel!,favourites: favourites,cart: cart,),
              FavouritesScreen(favourites: favourites,cart: cart,),
              CartScreen(favourites: favourites,cart: cart,),
            ];
            return screens[widget.currentIndex];
          } else {
            return const Center(
                child: CircularProgressIndicator(
              color: Colors.indigo,
            ));
          }
        },
      ),
      bottomNavigationBar: GNav(
        selectedIndex: widget.currentIndex,
        onTabChange: (value) {
          setState(() {
            widget.currentIndex = value;
          });
        },
        backgroundColor: Colors.white,
        color: Colors.black87,
        activeColor: Colors.indigo,
        hoverColor: Colors.indigo.withOpacity(0.2),
        tabBackgroundColor: Colors.indigo.withOpacity(0.2),
        gap: 8,
        tabs: const [
          GButton(
            icon: Icons.home_outlined,
            text: 'Home',
          ),
          GButton(
            icon: Icons.category_outlined,
            text: 'Categories',
          ),
          GButton(
            icon: Icons.favorite_outline,
            text: 'Favourites',
          ),
          GButton(
            icon: Icons.shopping_cart_outlined,
            text: 'Cart',
          ),
        ],
      ),
    );
  }
}
