import 'package:flutter/material.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';

class ProductGridTile extends StatelessWidget {
  final BuildContext context;
  final ProductEntity product;
  final Function() onPressed;

  const ProductGridTile({
    super.key,
    required this.context,
    required this.product,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
      elevation: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 185,
            height: 150,
            child: Image.network(
              product.image,
              fit: BoxFit.fill,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                const Icon(Icons.star_rounded, color: Colors.red, size: 20),
                Expanded(
                  child: Text(
                    product.title,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: "Lexend", fontSize: 15),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                "${product.price} \$",
                style: const TextStyle(
                    fontFamily: "Lexend",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart_checkout_rounded,
                    size: 35,
                  ),
                  onPressed: () {},
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}
