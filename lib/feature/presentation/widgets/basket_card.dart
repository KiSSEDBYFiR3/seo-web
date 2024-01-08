import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seo_web/core/common/colors/colors.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/core/common/utils/currency_extension.dart';

import 'package:seo_web/core/common/utils/seo_widget.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/widgets/favorites_button.dart';
import 'package:shimmer/shimmer.dart';

class BasketCard extends StatelessWidget {
  const BasketCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.deleteFromCart,
    required this.onFavoritesTap,
    required this.onProductTap,
  });

  final ProductEntity product;
  final void Function({required ProductEntity product}) deleteFromCart;
  final Future<void> Function(ProductEntity) onFavoritesTap;
  final Future<void> Function(int id) onProductTap;

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageSize = size.width <= 550 ? 100.0 : 150.0;
    final boxHeight = size.width <= 550 ? 150.0 : 200.0;
    final boxWidth = size.width <= 550 ? size.width : size.width * 0.55;

    final imageFlex = size.width >= 550 ? 2 : 1;
    final descpriptionFlex = size.width >= 550 ? 3 : 2;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onProductTap(product.id),
      child: SEOWidget(
        metaImageLink: product.image,
        metaAlt: 'Basket Offer Product Image - ${product.id}',
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: boxWidth,
            maxHeight: boxHeight,
          ),
          child: Row(
            mainAxisAlignment: size.width <= 550
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Expanded(
                flex: imageFlex,
                child: CachedNetworkImage(
                  imageUrl: product.image,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      height: imageSize,
                      width: imageSize,
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
                      height: imageSize,
                      width: imageSize,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: descpriptionFlex,
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 24, bottom: 24, left: 8, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 3,
                            child: Text(
                              product.title,
                              style: AppTypography.montserrat14w600,
                              maxLines: 4,
                            ),
                          ),
                          Expanded(
                            child: Align(
                              alignment: Alignment.topRight,
                              child: FavoritesButton(
                                key: ValueKey('favorite-button-${product.id}'),
                                isFavorite: isFavorite,
                                onTap: () async =>
                                    await onFavoritesTap(product),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              product.price.toPrice(),
                              style: AppTypography.montserrat14w600,
                            ),
                          ),
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () => deleteFromCart(product: product),
                              child: Align(
                                alignment: Alignment.bottomRight,
                                child:
                                    SvgPicture.asset('assets/svg/delete.svg'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
