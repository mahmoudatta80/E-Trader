import 'package:e_commerce_app/animation/animated_route.dart';
import 'package:e_commerce_app/models/api_model/softagi.dart';
import 'package:e_commerce_app/modules/single_category.dart';
import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  Softagi categoryModel;
  Map<int, bool> favourites;
  Map<int, bool> cart;

  CategoriesScreen(
      {Key? key,
      required this.categoryModel,
      required this.favourites,
      required this.cart})
      : super(key: key);

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) => Column(
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
                    page: SingleCategoryScreen(
                      favourites: widget.favourites,
                      cart: widget.cart,
                      id: widget.categoryModel.data!.categoryModel[index].id,
                      pageId: 1,
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
                        widget.categoryModel.data!.categoryModel[index].image,
                      ),
                      errorBuilder: (context, error, stackTrace) {
                        return Image.network(
                          'https://www.globalsign.com/application/files/9516/0389/3750/What_Is_an_SSL_Common_Name_Mismatch_Error_-_Blog_Image.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                      loadingBuilder: (context, child, loadingProgress) {
                        if(loadingProgress == null) {
                          return child;
                        }
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.indigo,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.categoryModel.data!.categoryModel[index].name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black45,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
        itemCount: widget.categoryModel.data!.categoryModel.length,
      ),
    );
  }
}
