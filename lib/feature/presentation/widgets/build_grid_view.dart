import 'package:flutter/material.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/widgets/product_tiles_grid.dart';

Widget buildGridView(
  BuildContext context,
  List<ProductEntity> products,
  Function(ProductEntity) onPressed,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: GridView.builder(
      itemCount: products.length,
      cacheExtent: 1000,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 185 / 260,
        mainAxisSpacing: 25,
        crossAxisSpacing: 5,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return ProductGridTile(
          context: context,
          product: products[index],
          onPressed: onPressed(products[index]),
        );
      },
    ),
  );
}
