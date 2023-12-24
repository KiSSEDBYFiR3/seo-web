import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_widget_model.dart';

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
      appBar: AppBar(
        toolbarHeight: 48,
        centerTitle: true,
        title: Text(
          wm.locale.cart,
          style: AppTypography.inter18w700,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 16),
        child: CustomScrollView(
          slivers: [],
        ),
      ),
    );
  }
}
