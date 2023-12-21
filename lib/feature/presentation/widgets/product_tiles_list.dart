import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

class ProductListTile extends StatelessWidget {
  final BuildContext context;
  final ProductEntity product;
  final Function() onPressed;

  const ProductListTile({
    super.key,
    required this.context,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 175,
      width: kIsWeb
          ? MediaQuery.of(context).size.width / 2
          : MediaQuery.of(context).size.width,
      child: Container(
        width: kIsWeb
            ? MediaQuery.of(context).size.width / 4
            : MediaQuery.of(context).size.width - 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(
            25,
          ),
          color: Theme.of(context).cardColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 190,
              height: 170,
              child: Image.network(
                product.image,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(
              height: 170,
              width: kIsWeb
                  ? MediaQuery.of(context).size.width / 3
                  : MediaQuery.of(context).size.width - 200,
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 5),
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 5,
                        ),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            product.title,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: "Lexend", fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              right: 5,
                            ),
                            child: Icon(Icons.star_rounded,
                                color: Colors.red, size: 30),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              "${product.price} \$",
                              style: const TextStyle(
                                  fontFamily: "Lexend",
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              icon: const Icon(
                                Icons.shopping_cart_checkout_rounded,
                                size: 30,
                              ),
                              onPressed: () => onPressed(),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
