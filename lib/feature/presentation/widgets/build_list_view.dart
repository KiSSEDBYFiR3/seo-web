import 'package:flutter/material.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/widgets/product_tiles_list.dart';

Widget buildListView(BuildContext context, List<ProductEntity> products,
    Function(ProductEntity) onPressed) {
  return ListView.separated(
    itemCount: products.length,
    cacheExtent: 1000,
    itemBuilder: (context, index) {
      return ProductListTile(
        context: context,
        product: products[index],
        onPressed: () {
          onPressed(products[index]);
        },
      );
    },
    separatorBuilder: (context, index) => const SizedBox(
      height: 8,
    ),
  );
}
