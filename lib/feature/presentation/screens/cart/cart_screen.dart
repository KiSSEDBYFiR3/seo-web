import 'package:auto_route/auto_route.dart';
import 'package:decimal/decimal.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/core/common/colors/colors.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/core/common/utils/currency_extension.dart';
import 'package:seo_web/feature/domain/entity/cart_offer_entity.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_widget_model.dart';
import 'package:seo_web/feature/presentation/widgets/mobile_basket_card.dart';
import 'package:seo_web/generated/l10n.dart';

@RoutePage(name: 'CartRoute')
class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const CartWidget(cartWMFactory);
  }
}

class CartWidget extends ElementaryWidget<ICartWidgetModel> {
  const CartWidget(super.wmFactory, {super.key});

  @override
  Widget build(ICartWidgetModel wm) {
    return Scaffold(
      floatingActionButton: EntityStateNotifierBuilder(
        listenableEntityState: wm.cartState,
        builder: (context, cart) {
          if (cart == null || cart.offers.isEmpty) {
            return const SizedBox.shrink();
          }
          return _OrderFloatingBar(
            createOrder: wm.orderCreate,
            locale: wm.locale,
            price: cart.price,
            offersCount: wm.offersCount,
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 48,
        centerTitle: true,
        leading: const SizedBox.shrink(),
        title: Text(
          wm.locale.cart.toUpperCase(),
          style: AppTypography.montserrat18w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 12),
        child: EntityStateNotifierBuilder(
          listenableEntityState: wm.favoritesState,
          builder: (context, _) => EntityStateNotifierBuilder(
            listenableEntityState: wm.cartState,
            builder: (context, cart) {
              if (cart == null || cart.offers.isEmpty) {
                return _EmptyPageWidget(
                  locale: wm.locale,
                  onTap: wm.goToCatalog,
                );
              }
              return _CartListView(
                offers: cart.offers,
                wm: wm,
              );
            },
            loadingBuilder: (context, cart) {
              if (cart == null || cart.offers.isEmpty) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return _CartListView(
                offers: cart.offers,
                wm: wm,
              );
            },
            errorBuilder: (context, _, cart) {
              if (cart == null || cart.offers.isEmpty) {
                return _EmptyPageWidget(
                  locale: wm.locale,
                  onTap: wm.goToCatalog,
                );
              }
              return _CartListView(
                offers: cart.offers,
                wm: wm,
              );
            },
          ),
        ),
      ),
    );
  }
}

class _EmptyPageWidget extends StatelessWidget {
  final S locale;
  final VoidCallback onTap;
  const _EmptyPageWidget({
    super.key,
    required this.locale,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              locale.emtpyCart,
              style: AppTypography.montserrat14w600,
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: Container(
              color: AppColors.buttonColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: Text(
                  locale.toCatalog,
                  style: AppTypography.montserrat14w600.copyWith(
                    color: AppColors.onButtonColor,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _OrderFloatingBar extends StatelessWidget {
  final S locale;
  final VoidCallback createOrder;
  final Decimal price;
  final int offersCount;
  const _OrderFloatingBar({
    super.key,
    required this.locale,
    required this.createOrder,
    required this.price,
    required this.offersCount,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 6;
    return Container(
      height: height,
      color: AppColors.orderFloatingBarColot,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8,
          left: 16,
          right: 16,
          bottom: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${locale.offersCount}:',
                        style: AppTypography.montserrat12w600,
                      ),
                      Text(
                        offersCount.toString(),
                        style: AppTypography.montserrat12w600,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${locale.basketPrice}:',
                        style: AppTypography.montserrat12w600,
                      ),
                      Text(
                        price.toPrice(),
                        style: AppTypography.montserrat12w600,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 2,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: createOrder,
                child: Container(
                  color: AppColors.buttonColor,
                  child: Center(
                    child: Text(
                      locale.createOrder,
                      style: AppTypography.montserrat16w600
                          .copyWith(color: AppColors.onButtonColor),
                    ),
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

class _CartListView extends StatelessWidget {
  final List<CartOfferEntity> offers;
  final ICartWidgetModel wm;
  const _CartListView({
    super.key,
    required this.offers,
    required this.wm,
  });

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverList.separated(
          itemCount: offers.length,
          itemBuilder: (context, index) {
            final offer = offers[index];
            return MobileBasketCard(
              key: ValueKey('offer-${offer.id}'),
              deleteFromCart: wm.deleteFromCart,
              onFavoritesTap: wm.onFavoriteTap,
              product: offer.product,
              isFavorite: wm.isInFavorites(offer.product),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(
            height: 8,
          ),
        )
      ],
    );
  }
}
