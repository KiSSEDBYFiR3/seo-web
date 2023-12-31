import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/core/common/colors/colors.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/core/common/utils/currency_extension.dart';

import 'package:seo_web/core/common/utils/seo_widget.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/widgets/favorites_button.dart';
import 'package:seo_web/generated/l10n.dart';
import 'package:shimmer/shimmer.dart';

class MobileProductCard extends StatelessWidget {
  final ProductEntity product;
  final bool isFavorite;
  final bool isInCart;
  final VoidCallback onFavoritesTap;
  final VoidCallback onCartButtonTap;
  final VoidCallback onProductTap;

  const MobileProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.isInCart,
    required this.onCartButtonTap,
    required this.onFavoritesTap,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width - 32;
    final locales = S.of(context);

    return SEOWidget(
      metaImageLink: product.image,
      metaAlt: 'Product Image - ${product.id}',
      child: Semantics(
        label: 'Product: ${product.title}',
        child: GestureDetector(
          onTap: onProductTap,
          child: ColoredBox(
            color: Colors.white,
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 18,
                      child: Semantics(
                        label: 'Product image',
                        child: CachedNetworkImage(
                          imageUrl: product.image,
                          imageBuilder: (context, imageProvider) {
                            return Container(
                              height: size.width * 0.4,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            );
                          },
                          placeholder: (context, url) => Shimmer.fromColors(
                            baseColor: AppColors.shimmerBaseColor,
                            highlightColor: AppColors.shimmerHighlightColor,
                            child: SizedBox(
                              height: width * 0.9 / 2,
                              width: width * 0.9 / 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            product.price.toPrice(),
                            style: AppTypography.montserrat14w600,
                            semanticsLabel: 'Product price: ${product.price}',
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          product.title,
                          style: AppTypography.montserrat14W400,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Row(
                        children: [
                          Expanded(
                            flex: 30,
                            child: GestureDetector(
                              onTap: onCartButtonTap,
                              child: Container(
                                color: AppColors.buttonColor,
                                child: Center(
                                  child: Text(
                                    isInCart
                                        ? locales.toCart
                                        : locales.addToCart,
                                    style:
                                        AppTypography.montserrat14W400.copyWith(
                                      color: AppColors.onButtonColor,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 4),
                              child: FavoritesButton(
                                key: ValueKey('favorite-button-${product.id}'),
                                isFavorite: isFavorite,
                                onTap: onFavoritesTap,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
