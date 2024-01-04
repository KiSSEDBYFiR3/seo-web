import 'package:auto_route/annotations.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:seo_web/core/common/colors/colors.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/core/icons/custom_icons.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/catalog/products/products_screen_widget_model.dart';
import 'package:seo_web/feature/presentation/widgets/mobile_product_card.dart';
import 'package:seo_web/feature/presentation/widgets/web_product_card.dart';
import 'package:seo_web/generated/l10n.dart';

@RoutePage(name: 'ProductsRoute')
class ProductsScreen extends StatelessWidget {
  const ProductsScreen({
    super.key,
    @QueryParam() this.category,
  });
  final String? category;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width > 550 ? 100 : 0),
      child: const ProductsWidget(catalogWMFactory),
    );
  }
}

class ProductsWidget extends ElementaryWidget<IProductsWidgetModel> {
  const ProductsWidget(super.wmFactory, {super.key});

  @override
  Widget build(IProductsWidgetModel wm) {
    if (kIsWeb) {
      final meta = MetaSEO();
      meta.ogTitle(ogTitle: wm.locale.allProducts);
      meta.description(description: wm.locale.allProducts);
      meta.keywords(
        keywords:
            'Catalog, Products, Product List, Список товаров, Каталог, Продукты',
      );
    }
    return GestureDetector(
      onTap: wm.unfocus,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: !kIsWeb
              ? GestureDetector(
                  onTap: wm.goBack,
                  child: const Icon(
                    Icons.arrow_back_ios,
                    size: 18,
                  ),
                )
              : const SizedBox.shrink(),
          toolbarHeight: 48,
          centerTitle: true,
          title: StreamBuilder<String>(
            stream: wm.selectedCategoryName,
            builder: (context, snapshot) {
              return Text(
                snapshot.data?.toUpperCase() ?? wm.locale.allProducts,
                style: AppTypography.montserrat18w700,
                semanticsLabel:
                    'Page Title: ${snapshot.data?.toUpperCase() ?? wm.locale.allProducts}',
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
                return wm.searchController.text.isEmpty
                    ? Center(
                        child: Text(
                          wm.locale.emtpyCatalog,
                          style: AppTypography.montserrat14W400,
                        ),
                      )
                    : _ProductsView(
                        wm: wm,
                        products: products ?? [],
                      );
              }
              return _ProductsView(wm: wm, products: products);
            },
            loadingBuilder: (context, products) {
              if (products == null || products.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return _ProductsView(wm: wm, products: products);
            },
            errorBuilder: (context, _, products) {
              if (products == null || products.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              return _ProductsView(wm: wm, products: products);
            },
          ),
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
    final size = MediaQuery.of(context).size;
    return Semantics(
      label: 'Products List',
      child: LayoutBuilder(
        builder: (context, constraints) => CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              floating: true,
              delegate: _SearchSliverDelegate(
                width: size.width,
                height: size.height / 17,
                locale: wm.locale,
                controller: wm.searchController,
              ),
            ),
            if (constraints.maxWidth <= 920)
              SliverGrid.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) => EntityStateNotifierBuilder(
                  listenableEntityState: wm.cartState,
                  builder: (context, _) => EntityStateNotifierBuilder(
                    listenableEntityState: wm.favoritesState,
                    builder: (context, _) => LayoutBuilder(
                      builder: (context, constraints) {
                        return MobileProductCard(
                          onProductTap: () =>
                              wm.onProductTap(products[index].id),
                          key: ValueKey('product-${products[index].id}'),
                          product: products[index],
                          isFavorite: wm.isInFavorites(products[index]),
                          isInCart: wm.isInCart(products[index]),
                          onCartButtonTap: () => wm.onCartTap(products[index]),
                          onFavoritesTap: () =>
                              wm.onFavoriteTap(products[index]),
                        );
                      },
                    ),
                  ),
                ),
              ),
            if (constraints.maxWidth > 920)
              SliverList.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => EntityStateNotifierBuilder(
                  listenableEntityState: wm.cartState,
                  builder: (context, _) => EntityStateNotifierBuilder(
                    listenableEntityState: wm.favoritesState,
                    builder: (context, _) => LayoutBuilder(
                      builder: (context, constraints) {
                        return WebProductCard(
                          onProductTap: () =>
                              wm.onProductTap(products[index].id),
                          key: ValueKey('product-${products[index].id}'),
                          product: products[index],
                          isFavorite: wm.isInFavorites(products[index]),
                          isInCart: wm.isInCart(products[index]),
                          onCartButtonTap: () => wm.onCartTap(products[index]),
                          onFavoritesTap: () =>
                              wm.onFavoriteTap(products[index]),
                          locale: wm.locale,
                        );
                      },
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _SearchSliverDelegate extends SliverPersistentHeaderDelegate {
  final double height;
  final double width;
  final S locale;
  final TextEditingController controller;

  const _SearchSliverDelegate({
    required this.height,
    required this.locale,
    required this.controller,
    required this.width,
  });

  @override
  Widget build(BuildContext context, _, __) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Container(
        color: AppColors.onButtonColor,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12, left: 4, right: 4),
          child: SizedBox(
            width: width,
            child: TextField(
              style: AppTypography.montserrat14W400,
              cursorColor: AppColors.buttonColor,
              controller: controller,
              decoration: const InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                label: Icon(CustomIcons.search),
                border: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(),
                focusColor: AppColors.buttonColor,
                focusedBorder: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
