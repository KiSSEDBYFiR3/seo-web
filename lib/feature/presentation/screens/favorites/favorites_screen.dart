import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/feature/presentation/screens/favorites/favorites_screen_widget_model.dart';

@RoutePage(name: 'FavoritesRoute')
class FavoritesScreen extends ElementaryWidget<IFavoritesWidgetModel> {
  const FavoritesScreen(super.wmFactory, {super.key});

  @override
  Widget build(IFavoritesWidgetModel wm) {
    return Scaffold();
  }
}
