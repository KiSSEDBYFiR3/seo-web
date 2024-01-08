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

class WebProductCard extends StatelessWidget {
  final ProductEntity product;
  final bool isFavorite;
  final bool isInCart;
  final VoidCallback onFavoritesTap;
  final VoidCallback onCartButtonTap;
  final VoidCallback onProductTap;
  final S locale;

  const WebProductCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.isInCart,
    required this.onFavoritesTap,
    required this.onCartButtonTap,
    required this.locale,
    required this.onProductTap,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SEOWidget(
      metaImageLink: product.image,
      metaAlt: 'Product Image - ${product.id}',
      child: Semantics(
        label: 'Product: ${product.title}',
        child: GestureDetector(
          onTap: onProductTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Container(
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerLeft,
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
                                height: size.width * 0.4,
                                width: size.width * 0.4,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 4),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        product.title,
                                        style: AppTypography.montserrat14w600,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 4,
                                      horizontal: 32,
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        product.price.toPrice(),
                                        style: AppTypography.montserrat14w600,
                                        semanticsLabel:
                                            'Product price: ${product.price}',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: Text(
                                    product.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTypography.montserrat12w600
                                        .copyWith(
                                            color: AppColors.descriptionColor),
                                  ),
                                ),
                                const Spacer(flex: 2),
                                Expanded(
                                  flex: 2,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 4,
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          SizedBox(
                                            width: 120,
                                            child: GestureDetector(
                                              onTap: onCartButtonTap,
                                              child: Container(
                                                height: 40,
                                                color: AppColors.buttonColor,
                                                child: Center(
                                                  child: Text(
                                                    isInCart
                                                        ? locale.toCart
                                                        : locale.addToCart,
                                                    style: AppTypography
                                                        .montserrat14W400
                                                        .copyWith(
                                                      color: AppColors
                                                          .onButtonColor,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                              horizontal: 4,
                                            ),
                                            child: FavoritesButton(
                                              key: ValueKey(
                                                  'favorite-button-${product.id}'),
                                              isFavorite: isFavorite,
                                              onTap: onFavoritesTap,
                                            ),
                                          ),
                                        ],
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
