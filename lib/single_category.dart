import 'package:e_commerce_app/animated_route.dart';
import 'package:e_commerce_app/cart_model.dart';
import 'package:e_commerce_app/db_helper.dart';
import 'package:e_commerce_app/details.dart';
import 'package:e_commerce_app/dio_helper.dart';
import 'package:e_commerce_app/favourites_model.dart';
import 'package:e_commerce_app/home.dart';
import 'package:e_commerce_app/second_animated_route.dart';
import 'package:e_commerce_app/softagi.dart';
import 'package:flutter/material.dart';

class SingleCategoryScreen extends StatefulWidget {
  final id;
  final pageId;
  Map<int, bool> favourites;
  Map<int, bool> cart;

  SingleCategoryScreen(
      {Key? key,
      required this.id,
      required this.pageId,
      required this.favourites,
      required this.cart,
      })
      : super(key: key);

  @override
  State<SingleCategoryScreen> createState() => _SingleCategoryScreenState();
}

class _SingleCategoryScreenState extends State<SingleCategoryScreen> {
  Softagi? singleCategoryModel;
  DbHelper? helper;
  bool cartEnd = false;
  bool favouriteEnd = false;

  @override
  void initState() {
    setState(() {
      cartEnd = false;
      favouriteEnd = false;
    });

    helper = DbHelper();

    super.initState();
    DioHelper.getSingleCategory(widget.id).then((value) {
      singleCategoryModel = Softagi.fromJson(value.data);
    }).then((value) {
      helper!.readAllFavourites().then((value) {
        for (var e in singleCategoryModel!.data!.singleCategoryModel) {
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
                page: HomeLayout(
                  currentIndex: 1,
                ),
              ),
              (route) => false);
        } else {
          null;
        }
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(14.0),
            child: FutureBuilder(
              future: DioHelper.getSingleCategory(widget.id),
              builder: (context, snapshot) {
                if (favouriteEnd == true && cartEnd == true) {
                  return GridView.builder(
                    itemCount:
                        singleCategoryModel!.data!.singleCategoryModel.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: .5,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => InkWell(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      highlightColor: Colors.white,
                      splashColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).push(
                          AnimatedRoute(
                              page: DetailsScreen(
                                wherePageId: widget.pageId,
                                categoryId: widget.id,
                            favourites: widget.favourites,
                            cart: widget.cart,
                            pageId: 1,
                            id: singleCategoryModel!
                                .data!.singleCategoryModel[index].id,
                            image: singleCategoryModel!
                                .data!.singleCategoryModel[index].image,
                            description: singleCategoryModel!
                                .data!.singleCategoryModel[index].description,
                            name: singleCategoryModel!
                                .data!.singleCategoryModel[index].name,
                            price: singleCategoryModel!
                                .data!.singleCategoryModel[index].price,
                          )),
                        );
                      },
                      child: Container(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        margin: const EdgeInsetsDirectional.all(
                          5,
                        ),
                        decoration: const BoxDecoration(
                          // color: Colors.indigo.withOpacity(0.2),
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              10,
                            ),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  alignment: Alignment.bottomRight,
                                  children: [
                                    Image(
                                      image: NetworkImage(
                                        singleCategoryModel!.data!
                                            .singleCategoryModel[index].image,
                                      ),
                                      //fit: BoxFit.cover,
                                      height: 130,
                                      width: double.infinity,
                                    ),
                                    widget.cart[singleCategoryModel!.data!
                                            .singleCategoryModel[index].id]!
                                        ? Container(
                                            padding: const EdgeInsets.all(
                                              5,
                                            ),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.indigo.withOpacity(.2),
                                              borderRadius:
                                                  const BorderRadiusDirectional
                                                      .only(
                                                topStart: Radius.circular(
                                                  8,
                                                ),
                                                bottomEnd: Radius.circular(
                                                  8,
                                                ),
                                              ),
                                            ),
                                            child: const Text(
                                              'Added',
                                              style: TextStyle(
                                                color: Colors.indigo,
                                                fontSize: 13,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          )
                                        : InkWell(
                                            onTap: () {
                                              CartModel cartModel = CartModel({
                                                'image': singleCategoryModel!
                                                    .data!
                                                    .singleCategoryModel[index]
                                                    .image,
                                                'name': singleCategoryModel!
                                                    .data!
                                                    .singleCategoryModel[index]
                                                    .name,
                                                'id': singleCategoryModel!
                                                    .data!
                                                    .singleCategoryModel[index]
                                                    .id,
                                                'price': singleCategoryModel!
                                                    .data!
                                                    .singleCategoryModel[index]
                                                    .price,
                                                'description':
                                                    singleCategoryModel!
                                                        .data!
                                                        .singleCategoryModel[
                                                            index]
                                                        .description,
                                                'count': 1,
                                              });
                                              helper!.insertToCart(cartModel);
                                              setState(() {
                                                widget.cart[singleCategoryModel!
                                                    .data!
                                                    .singleCategoryModel[index]
                                                    .id] = true;
                                              });
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(
                                                5,
                                              ),
                                              decoration: const BoxDecoration(
                                                color: Colors.indigo,
                                                borderRadius:
                                                    BorderRadiusDirectional
                                                        .only(
                                                  topStart: Radius.circular(
                                                    8,
                                                  ),
                                                  bottomEnd: Radius.circular(
                                                    8,
                                                  ),
                                                ),
                                              ),
                                              child: const Text(
                                                'Add to Cart',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  singleCategoryModel!
                                      .data!.singleCategoryModel[index].name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  '${singleCategoryModel!.data!.singleCategoryModel[index].price} L.E',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black45,
                                  ),
                                ),
                              ],
                            ),
                            widget.favourites[singleCategoryModel!
                                    .data!.singleCategoryModel[index].id]!
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      hoverColor: Colors.white,
                                      focusColor: Colors.white,
                                      highlightColor: Colors.white,
                                      splashColor: Colors.white,
                                      onTap: () {
                                        helper!.deleteFromFavourites(
                                            singleCategoryModel!
                                                .data!.productModel[index].id);
                                        setState(() {
                                          widget.favourites[singleCategoryModel!
                                              .data!
                                              .productModel[index]
                                              .id] = false;
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
                                          'image': singleCategoryModel!
                                              .data!.productModel[index].image,
                                          'name': singleCategoryModel!
                                              .data!.productModel[index].name,
                                          'id': singleCategoryModel!
                                              .data!.productModel[index].id,
                                          'price': singleCategoryModel!
                                              .data!.productModel[index].price,
                                          'description': singleCategoryModel!
                                              .data!
                                              .productModel[index]
                                              .description,
                                        });
                                        helper!.insertToFavourites(
                                            favouritesModel);
                                        setState(() {
                                          widget.favourites[singleCategoryModel!
                                              .data!
                                              .productModel[index]
                                              .id] = true;
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
                      ),
                    ),
                  );
                } else {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: Colors.indigo,
                  ));
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
