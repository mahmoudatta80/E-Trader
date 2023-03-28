import 'package:e_commerce_app/animated_route.dart';
import 'package:e_commerce_app/db_helper.dart';
import 'package:e_commerce_app/details.dart';
import 'package:e_commerce_app/favourites_model.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  Map<int, bool> favourites;
  Map<int, bool> cart;
  FavouritesScreen({Key? key, required this.favourites,required this.cart}) : super(key: key);

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  DbHelper? helper;

  @override
  void initState() {
    super.initState();
    helper = DbHelper();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: FutureBuilder(
        future: helper!.readAllFavourites(),
        builder: (context,AsyncSnapshot? snapshot) {
          if(!snapshot!.hasData) {
            return const Center(child: CircularProgressIndicator(color: Colors.indigo,));
          }else {
            return GridView.builder(
              itemCount: snapshot.data.length,
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: .5,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                FavouritesModel favouritesModel = FavouritesModel.fromJson(snapshot.data[index]);
                return InkWell(
                  hoverColor: Colors.white,
                  focusColor: Colors.white,
                  highlightColor: Colors.white,
                  splashColor: Colors.white,
                  onTap: () {
                    Navigator.of(context).push(
                      AnimatedRoute(page: DetailsScreen(
                        pageId: 2,
                        favourites: widget.favourites,
                        cart: widget.cart,
                        id: favouritesModel.id,
                        image: favouritesModel.image,
                        description: favouritesModel.description,
                        name: favouritesModel.name,
                        price: favouritesModel.price.toString(),
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
                                    favouritesModel.image,
                                  ),
                                  //fit: BoxFit.cover,
                                  height: 130,
                                  width: double.infinity,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.all(
                                      5,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadiusDirectional.only(
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
                              favouritesModel.name,
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
                              '${favouritesModel.price} L.E',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black45,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                helper!.deleteFromFavourites(favouritesModel.id);
                              });
                            },
                            child: const Icon(
                              Icons.favorite,
                              size: 24,
                              color: Colors.indigo,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
