import 'package:e_commerce_app/models/db_model/cart_model.dart';
import 'package:e_commerce_app/modules/single_category.dart';
import 'package:e_commerce_app/network/local/db_helper.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:e_commerce_app/models/db_model/favourites_model.dart';
import 'package:e_commerce_app/layout/home.dart';
import 'package:e_commerce_app/animation/second_animated_route.dart';
import 'package:e_commerce_app/models/api_model/softagi.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatefulWidget {
  final int pageId;
  final int id;
  final String image;
  final String name;
  final String price;
  final String description;
  Map<int, bool> favourites;
  Map<int, bool> cart;
  int? categoryId;
  int? wherePageId;

  DetailsScreen(
      {Key? key,
      required this.favourites,
      required this.cart,
      required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.description,
      required this.pageId,
      this.wherePageId,
      this.categoryId})
      : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  DbHelper? helper;
  Softagi? productModel;
  bool cartEnd = false;
  bool favouriteEnd = false;
  int count = 1;

  @override
  void initState() {
    setState(() {
      cartEnd = false;
      favouriteEnd = false;
    });
    super.initState();
    helper = DbHelper();
    DioHelper.getProduct().then((value) {
      productModel = Softagi.fromJson(value.data);
    }).then((value) {
      for (var e in productModel!.data!.productModel) {
        widget.favourites[e.id] = false;
        widget.cart[e.id] = false;
      }
    }).then((value) {
      helper!.readAllFavourites().then((value) {
        for (var e in value) {
          widget.favourites[e['id']] = true;
        }
      }).then((value) {
        setState(() {
          favouriteEnd = true;
        });
      });

      helper!.readAllCart().then((value) {
        for (var e in value) {
          widget.cart[e['id']] = true;
        }
      }).then((value) {
        setState(() {
          cartEnd = true;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (widget.pageId == 0) {
          Navigator.of(context).pushAndRemoveUntil(
              SecondAnimatedRoute(
                page: HomeLayout(
                  currentIndex: 0,
                ),
              ),
              (route) => false);
        } else if (widget.pageId == 1) {
          Navigator.of(context).pushAndRemoveUntil(
              SecondAnimatedRoute(
                page: SingleCategoryScreen(id: widget.categoryId,favourites: widget.favourites,cart: widget.cart,pageId: widget.wherePageId),
              ),
                  (route) => false);
        } else if (widget.pageId == 2) {
          Navigator.of(context).pushAndRemoveUntil(
              SecondAnimatedRoute(
                page: HomeLayout(currentIndex: 2),
              ),
              (route) => false);
        } else if (widget.pageId == 3) {
          Navigator.of(context).pushAndRemoveUntil(
              SecondAnimatedRoute(
                page: HomeLayout(currentIndex: 3),
              ),
              (route) => false);
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Container(
                  height: 280,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      //fit: BoxFit.cover,
                      image: NetworkImage(
                        widget.image,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  '${widget.price} L.E',
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          widget.favourites[widget.id]!
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    hoverColor: Colors.white,
                                    focusColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                    onTap: () {
                                      helper!.deleteFromFavourites(widget.id);
                                      setState(() {
                                        widget.favourites[widget.id] = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.favorite,
                                      size: 24,
                                      color: Colors.indigo,
                                    ),
                                  ),
                                )
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                    hoverColor: Colors.white,
                                    focusColor: Colors.white,
                                    highlightColor: Colors.white,
                                    splashColor: Colors.white,
                                    onTap: () {
                                      FavouritesModel favouritesModel =
                                          FavouritesModel({
                                        'image': widget.image,
                                        'name': widget.name,
                                        'id': widget.id,
                                        'price': widget.price,
                                        'description': widget.description,
                                      });
                                      helper!
                                          .insertToFavourites(favouritesModel);
                                      setState(() {
                                        widget.favourites[widget.id] = true;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.favorite_outline,
                                      size: 24,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 1.0,
                        color: Colors.indigo.withOpacity(
                          .7,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Explanation',
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.description,
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Container(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            width: 140,
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.indigo.withOpacity(.2),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  13,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    if (count != 1) {
                                      setState(() {
                                        count--;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.remove,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      '$count',
                                      style: const TextStyle(
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    if (count != 20) {
                                      setState(() {
                                        count++;
                                      });
                                    }
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    width: 35,
                                    decoration: const BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${count * double.parse(widget.price)} L.E',
                            style: const TextStyle(
                              color: Colors.black87,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      widget.cart[widget.id]!
                          ? Container(
                              height: 45,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.indigo.withOpacity(.2),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: const Center(
                                child: Text(
                                  'Added',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ),
                            )
                          : InkWell(
                              onTap: () {
                                CartModel cartModel = CartModel({
                                  'image': widget.image,
                                  'name': widget.name,
                                  'id': widget.id,
                                  'price': (count * double.parse(widget.price))
                                      .toString(),
                                  'description': widget.description,
                                  'count': count,
                                });
                                helper!.insertToCart(cartModel);
                                setState(() {
                                  widget.cart[widget.id] = true;
                                });
                              },
                              child: Container(
                                height: 45,
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: Colors.indigo,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Text(
                                        'Add to my Cart ',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Icon(
                                        Icons.shopping_cart_outlined,
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
