import 'package:e_commerce_app/animation/animated_route.dart';
import 'package:e_commerce_app/models/db_model/cart_model.dart';
import 'package:e_commerce_app/modules/single_category.dart';
import 'package:e_commerce_app/network/local/db_helper.dart';
import 'package:e_commerce_app/modules/details.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:e_commerce_app/models/db_model/favourites_model.dart';
import 'package:e_commerce_app/models/api_model/softagi.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  Softagi productModel;
  Softagi categoryModel;
  Map<int, bool> favourites;
  Map<int, bool> cart;

  ProductsScreen(
      {Key? key,
      required this.productModel,
      required this.categoryModel,
      required this.favourites,
      required this.cart})
      : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  DbHelper? helper;
  bool cartEnd = false;
  bool favouriteEnd = false;

  @override
  void initState() {
    setState(() {
      cartEnd = false;
      favouriteEnd = false;
    });
    super.initState();
    helper = DbHelper();
    helper!.readAllFavourites().then((value) {
      for (var e in widget.productModel.data!.productModel) {
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
    return FutureBuilder(
      future: DioHelper.getProduct(),
      builder: (context, snapshot) {
        if (favouriteEnd == true && cartEnd == true) {
          return Padding(
            padding: const EdgeInsets.all(14.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount:
                          widget.categoryModel.data!.categoryModel.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsetsDirectional.only(
                          top: 5,
                          end: 8,
                          start: 8,
                          bottom: 5,
                        ),
                        child: InkWell(
                          hoverColor: Colors.white,
                          focusColor: Colors.white,
                          highlightColor: Colors.white,
                          splashColor: Colors.white,
                          onTap: () {
                            Navigator.of(context).push(
                              AnimatedRoute(
                                page: SingleCategoryScreen(
                                  favourites: widget.favourites,
                                  cart: widget.cart,
                                  id: widget.categoryModel.data!
                                      .categoryModel[index].id,
                                  pageId: 0,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 80,
                                width: 80,
                                child: Image(
                                  //fit: BoxFit.cover,
                                  image: NetworkImage(
                                    widget.categoryModel.data!
                                        .categoryModel[index].image,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                widget.categoryModel.data!.categoryModel[index]
                                    .name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 2.5,
                    color: Colors.indigo,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    'Discover Our Products',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: widget.productModel.data!.productModel.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: .5,
                            mainAxisSpacing: 10),
                    itemBuilder: (context, index) => InkWell(
                      hoverColor: Colors.white,
                      focusColor: Colors.white,
                      highlightColor: Colors.white,
                      onTap: () {
                        Navigator.of(context).push(
                          AnimatedRoute(
                              page: DetailsScreen(
                            favourites: widget.favourites,
                            cart: widget.cart,
                            pageId: 0,
                            id: widget
                                .productModel.data!.productModel[index].id,
                            image: widget
                                .productModel.data!.productModel[index].image,
                            description: widget.productModel.data!
                                .productModel[index].description,
                            name: widget
                                .productModel.data!.productModel[index].name,
                            price: widget
                                .productModel.data!.productModel[index].price,
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
                              8,
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
                                        widget.productModel.data!.productModel[index].image,
                                      ),
                                      // fit: BoxFit.cover,
                                      height: 130,
                                      width: double.infinity,
                                    ),
                                    widget.cart[widget.productModel.data!
                                            .productModel[index].id]!
                                        ? Container(
                                            padding: const EdgeInsets.all(
                                              5,
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.indigo.withOpacity(.2),
                                              borderRadius: const BorderRadiusDirectional.only(
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
                                                'image': widget
                                                    .productModel
                                                    .data!
                                                    .productModel[index]
                                                    .image,
                                                'name': widget
                                                    .productModel
                                                    .data!
                                                    .productModel[index]
                                                    .name,
                                                'id': widget.productModel.data!
                                                    .productModel[index].id,
                                                'price': widget
                                                    .productModel
                                                    .data!
                                                    .productModel[index]
                                                    .price,
                                                'description': widget
                                                    .productModel
                                                    .data!
                                                    .productModel[index]
                                                    .description,
                                                'count': 1,
                                              });
                                              helper!.insertToCart(cartModel);
                                              setState(() {
                                                widget.cart[widget
                                                    .productModel
                                                    .data!
                                                    .productModel[index]
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
                                  widget.productModel.data!.productModel[index]
                                      .name,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Text(
                                  '${widget.productModel.data!.productModel[index].price} L.E',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                            widget.favourites[widget
                                    .productModel.data!.productModel[index].id]!
                                ? Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: () {
                                        helper!.deleteFromFavourites(widget
                                            .productModel
                                            .data!
                                            .productModel[index]
                                            .id);
                                        setState(() {
                                          widget.favourites[widget
                                              .productModel
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
                                      onTap: () {
                                        FavouritesModel favouritesModel =
                                            FavouritesModel({
                                          'image': widget.productModel.data!
                                              .productModel[index].image,
                                          'name': widget.productModel.data!
                                              .productModel[index].name,
                                          'id': widget.productModel.data!
                                              .productModel[index].id,
                                          'price': widget.productModel.data!
                                              .productModel[index].price,
                                          'description': widget
                                              .productModel
                                              .data!
                                              .productModel[index]
                                              .description,
                                        });
                                        helper!.insertToFavourites(
                                            favouritesModel);
                                        setState(() {
                                          widget.favourites[widget
                                              .productModel
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
                  ),
                ],
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
    );
  }
}
