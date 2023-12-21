import 'package:auto_route/annotations.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/feature/presentation/screens/catalog/catalog_screen_widget_model.dart';

@RoutePage(name: 'CatalogRoute')
class CatalogScreen extends ElementaryWidget<ICatalogWidgetModel> {
  const CatalogScreen(super.wmFactory, {super.key});

  @override
  Widget build(ICatalogWidgetModel context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [],
      ),
    );
  }
}
