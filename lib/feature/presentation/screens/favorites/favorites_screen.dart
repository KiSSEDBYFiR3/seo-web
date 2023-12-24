import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_widget_model.dart';
import 'package:seo_web/feature/presentation/widgets/mobile_product_cart.dart';

@RoutePage(name: 'FavoritesRoute')
class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavoritesWidget(favoritesWMFactory);
  }
}

class FavoritesWidget extends ElementaryWidget<IFavoritesWidgetModel> {
  const FavoritesWidget(super.wmFactory, {super.key});

  @override
  Widget build(IFavoritesWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 48,
        centerTitle: true,
        title: Text(
          wm.locale.favorites,
          style: AppTypography.inter18w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: EntityStateNotifierBuilder(
          listenableEntityState: wm.favoritesState,
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
  final IFavoritesWidgetModel wm;
  final List<ProductEntity> products;

  const _ProductsView({
    super.key,
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
                    builder: (context, _) => SizedBox(
                      height: 350,
                      child: MobileProductCart(
                        key: ValueKey('product-${products[index].id}'),
                        product: products[index],
                        isFavorite: wm.isInFavorites(products[index]),
                        isInCart: wm.isInCart(products[index]),
                        onCartButtonTap: () => wm.onCartTap(products[index]),
                        onFavoritesTap: () => wm.onFavoriteTap(products[index]),
                      ),
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }
}
