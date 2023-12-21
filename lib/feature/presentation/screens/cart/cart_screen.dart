import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/feature/presentation/screens/cart/cart_screen_widget_model.dart';

@RoutePage(name: 'CartRoute')
class CartScreen extends ElementaryWidget<ICartWidgetModel> {
  const CartScreen(super.wmFactory, {super.key});

  @override
  Widget build(ICartWidgetModel wm) {
    return const Scaffold(
      body: CustomScrollView(
        cacheExtent: 400,
        slivers: [],
      ),
    );
  }
}
