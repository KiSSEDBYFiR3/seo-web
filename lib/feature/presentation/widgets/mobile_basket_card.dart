import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:seo_web/core/common/colors/colors.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/core/common/utils/currency_extension.dart';
import 'package:seo_web/feature/domain/entity/products_entity.dart';
import 'package:seo_web/feature/presentation/widgets/favorites_button.dart';
import 'package:shimmer/shimmer.dart';

class MobileBasketCard extends StatelessWidget {
  const MobileBasketCard({
    super.key,
    required this.product,
    required this.isFavorite,
    required this.deleteFromCart,
    required this.onFavoritesTap,
  });

  final ProductEntity product;
  final void Function({required ProductEntity product}) deleteFromCart;
  final Future<void> Function(ProductEntity) onFavoritesTap;

  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.centerLeft,
              child: CachedNetworkImage(
                imageUrl: product.image,
                imageBuilder: (context, imageProvider) {
                  return Container(
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
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                            isFavorite: isFavorite,
                            onTap: () async => await onFavoritesTap(product),
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
                            child: SvgPicture.asset('assets/svg/delete.svg'),
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
    );
  }
}
