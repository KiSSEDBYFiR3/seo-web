import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:seo_web/feature/presentation/screens/catalog/categories/categories_screen.dart';
import 'package:seo_web/feature/presentation/screens/catalog/categories/categories_screen_model.dart';
import 'package:seo_web/generated/l10n.dart';

abstract interface class ICategoriesScreenWidgetModel
    extends WidgetModel<CategoriesWidget, ICategoriesModel> {
  ICategoriesScreenWidgetModel({
    required ICategoriesModel model,
  }) : super(model);

  void getCategories();

  S get locale;

  Future<void> selectCategory(String category);

  EntityStateNotifier<List<String>> get categoriesState;
}

ICategoriesScreenWidgetModel categoriesScreenWMFactory(BuildContext context) =>
    CategoriesScreenWidgetModel(
      model: context.read<ICategoriesModel>(),
    );

final class CategoriesScreenWidgetModel
    extends WidgetModel<CategoriesWidget, ICategoriesModel>
    implements ICategoriesScreenWidgetModel {
  final ICategoriesModel _model;

  CategoriesScreenWidgetModel({
    required ICategoriesModel model,
  })  : _model = model,
        super(model);

  StackRouter get _router => AutoRouter.of(context);

  @override
  EntityStateNotifier<List<String>> get categoriesState =>
      _model.categoriesState;

  @override
  void getCategories() => _model.getCategories();

  @override
  Future<void> selectCategory(String category) async {
    _model.selectCategory(category);

    await _router.push(const ProductsRoute());
  }

  @override
  S get locale => S.of(context);
}
