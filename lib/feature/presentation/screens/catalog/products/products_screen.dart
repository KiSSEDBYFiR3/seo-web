import 'package:auto_route/annotations.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen_widget_model.dart';
import 'package:seo_web/feature/presentation/widgets/mobile_product_card.dart';

@RoutePage(name: 'ProductsRoute')
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductsWidget(catalogWMFactory);
  }
}

class ProductsWidget extends ElementaryWidget<IProductsWidgetModel> {
  const ProductsWidget(super.wmFactory, {super.key});

  @override
  Widget build(IProductsWidgetModel wm) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: wm.goBack,
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        toolbarHeight: 48,
        centerTitle: true,
        title: StreamBuilder<String>(
          stream: wm.selectedCategoryName,
          builder: (context, snapshot) {
            return Text(
              snapshot.data?.toUpperCase() ?? wm.locale.allProducts,
              style: AppTypography.montserrat18w700,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: EntityStateNotifierBuilder(
          listenableEntityState: wm.productsState,
          builder: (context, products) {
            if (products == null || products.isEmpty) {
              return Center(
                child: Text(wm.locale.emtpyCatalog),
              );
            }
            return _ProductsView(wm: wm, products: products);
          },
          loadingBuilder: (context, products) {
            if (products == null || products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _ProductsView(wm: wm, products: products);
          },
          errorBuilder: (context, _, products) {
            if (products == null || products.isEmpty) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return _ProductsView(wm: wm, products: products);
          },
        ),
      ),
    );
  }
}

class _ProductsView extends StatelessWidget {
  final IProductsWidgetModel wm;
  final List<ProductEntity> products;

  const _ProductsView({
    required this.wm,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          itemCount: products.length,
          itemBuilder: (context, index) => !kIsWeb
              ? EntityStateNotifierBuilder(
                  listenableEntityState: wm.cartState,
                  builder: (context, _) => EntityStateNotifierBuilder(
                    listenableEntityState: wm.favoritesState,
                    builder: (context, _) => MobileProductCart(
                      key: ValueKey('product-${products[index].id}'),
                      product: products[index],
                      isFavorite: wm.isInFavorites(products[index]),
                      isInCart: wm.isInCart(products[index]),
                      onCartButtonTap: () => wm.onCartTap(products[index]),
                      onFavoritesTap: () => wm.onFavoriteTap(products[index]),
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
