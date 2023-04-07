import 'package:e_commerce_app/animation/animated_route.dart';
import 'package:e_commerce_app/models/db_model/cart_model.dart';
import 'package:e_commerce_app/network/local/db_helper.dart';
import 'package:e_commerce_app/modules/details.dart';
import 'package:e_commerce_app/network/remote/dio_helper.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  Map<int, bool> favourites;
  Map<int, bool> cart;
  CartScreen({Key? key,required this.favourites,required this.cart}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  DbHelper? helper;
  double totalPrice = 0;
  bool end = false;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();

    helper!.readAllCart().then((value) {
      for (var e in value) {
        totalPrice = totalPrice + (e['count']*e['price']);
      }
    }).then((value) {
      setState(() {
        end = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: FutureBuilder(
        future: helper!.readAllCart(),
        builder: (context,AsyncSnapshot? snapshot) {
          if(!snapshot!.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.indigo,));
          }else {
            return SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      CartModel cartModel = CartModel.fromJson(snapshot.data[index]);
                      return Dismissible(
                        key: ValueKey(cartModel),
                        onDismissed: (value) {
                          helper!.deleteFromCart(cartModel.id);
                          setState(() {
                            totalPrice = totalPrice - cartModel.price;
                          });
                        },
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            InkWell(
                              hoverColor: Colors.white,
                              focusColor: Colors.white,
                              highlightColor: Colors.white,
                              splashColor: Colors.white,
                              borderRadius: const BorderRadius.all(
                                Radius.circular(
                                  10,
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  AnimatedRoute(
                                    page: DetailsScreen(
                                      favourites: widget.favourites,
                                      cart: widget.cart,
                                      pageId: 3,
                                      id: cartModel.id,
                                      image: cartModel.image,
                                      description: cartModel.description,
                                      name: cartModel.name,
                                      price: cartModel.price.toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          10,
                                        ),
                                      ),
                                    ),
                                    height: 100,
                                    width: 100,
                                    child: Image(
                                      //fit: BoxFit.cover,
                                      image: NetworkImage(
                                        cartModel.image,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Text(
                                      cartModel.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'count',
                                      ),
                                      Text(
                                        '${cartModel.count}',
                                        style: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Column(
                                    children: [
                                      const Text(
                                        'Price',
                                      ),
                                      Text(
                                        '${cartModel.price} L.E',
                                        style: const TextStyle(
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      );
                    },
                    itemCount: snapshot.data.length,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 2.5,
                    color: Colors.indigo.withOpacity(.7),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children:[
                      const Expanded(
                        child: Text(
                          'Total Price',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        '$totalPrice L.E',
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {},
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
                              'Order Now ',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
