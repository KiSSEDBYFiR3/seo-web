import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:seo_web/core/common/colors/colors.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/core/common/utils/currency_extension.dart';
import 'package:seo_web/core/common/utils/seo_helper.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/screens/catalog/product_card/product_card_screen_widget_model.dart';
import 'package:seo_web/feature/presentation/widgets/favorites_button.dart';
import 'package:shimmer/shimmer.dart';

@RoutePage(name: 'ProductCardRoute')
class ProductCardScreen extends StatelessWidget {
  final int? id;
  const ProductCardScreen({
    super.key,
    @QueryParam() this.id,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.only(left: width > 550 ? 100 : 0),
      child: ProductCardWidget(
        (context) => productWMFactory(context, id ?? 0),
      ),
    );
  }
}

class ProductCardWidget extends ElementaryWidget<IProductWidgetModel> {
  const ProductCardWidget(super.wmFactory, {super.key});

  @override
  Widget build(IProductWidgetModel wm) {
    if (kIsWeb) {
      SEOHelper.addInfo(title: wm.locale.productCard);

      final meta = MetaSEO();
      meta.ogTitle(ogTitle: wm.locale.productCard);
      meta.description(description: wm.locale.productCard);
      meta.keywords(
        keywords: 'Product Card, Product, Продукт, Карточка товара',
      );
    }
    return Scaffold(
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
      ),
      body: StreamBuilder<ProductEntity>(
        stream: wm.selectedProductController,
        builder: (context, snapshot) {
          final product = snapshot.data;
          final size = MediaQuery.of(context).size;
          if (product == null) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }

          SEOHelper.addInfo(
            imageLink: product.image,
            imageAlt: 'Product Image',
          );

          return LayoutBuilder(
            builder: (context, constraints) => Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: Stack(
                      fit: constraints.maxWidth > 550
                          ? StackFit.loose
                          : StackFit.expand,
                      children: [
                        CachedNetworkImage(
                          imageUrl: product.image,
                          imageBuilder: (context, imageProvider) {
                            return Image(
                              image: imageProvider,
                              height: size.height * 0.15,
                              width: constraints.maxHeight > 550
                                  ? size.width / 5
                                  : size.width,
                            );
                          },
                          placeholder: (context, url) {
                            return Shimmer.fromColors(
                              baseColor: AppColors.shimmerBaseColor,
                              highlightColor: AppColors.shimmerHighlightColor,
                              child: SizedBox(
                                height: size.height * 0.3,
                                width: size.width,
                              ),
                            );
                          },
                        ),
                        EntityStateNotifierBuilder(
                          listenableEntityState: wm.favoritesState,
                          builder: (context, _) => Positioned(
                            right: 5,
                            top: 5,
                            child: FavoritesButton(
                              key: ValueKey('favorite-button-${product.id}'),
                              isFavorite: wm.isInFavorites(product),
                              onTap: () => wm.onFavoritesTap(product: product),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Text(
                            product.title,
                            style: AppTypography.montserrat14w600,
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: size.width > 550
                                ? Alignment.center
                                : Alignment.centerLeft,
                            child: Text(
                              product.price.toPrice(),
                              style: AppTypography.montserrat16w600,
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 3,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              top: 12,
                              bottom: 8,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: size.width > 550 ? 400 : 0,
                              ),
                              child: Text(
                                product.description,
                                textAlign: TextAlign.justify,
                                style: AppTypography.montserrat14W400.copyWith(
                                  color: AppColors.descriptionColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                vertical: constraints.maxWidth > 550 ? 48 : 36),
                            child: GestureDetector(
                              onTap: () => wm.addToCart(product: product),
                              child: EntityStateNotifierBuilder(
                                listenableEntityState: wm.cartState,
                                builder: (context, data) {
                                  final isInCart = wm.isInCart(product);
                                  return Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: constraints.maxWidth > 550
                                          ? constraints.maxWidth / 2.6
                                          : 0,
                                    ),
                                    child: Container(
                                      color: AppColors.buttonColor,
                                      child: Center(
                                        child: Text(
                                          isInCart
                                              ? wm.locale.toCart
                                              : wm.locale.addToCart,
                                          style: AppTypography.montserrat14w600
                                              .copyWith(
                                            color: AppColors.onButtonColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
