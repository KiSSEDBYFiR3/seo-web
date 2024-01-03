// ignore_for_file: unused_element

import 'package:auto_route/annotations.dart';
import 'package:elementary/elementary.dart';
import 'package:elementary_helper/elementary_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta_seo/meta_seo.dart';
import 'package:seo_web/core/common/typography/typography.dart';
import 'package:seo_web/core/common/utils/casing_extension.dart';
import 'package:seo_web/feature/presentation/screens/catalog/categories/categories_screen_widget_model.dart';

@RoutePage(name: 'CategoriesRoute')
class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(left: width > 550 ? 100 : 0),
      child: const CategoriesWidget(categoriesScreenWMFactory),
    );
  }
}

class CategoriesWidget extends ElementaryWidget<ICategoriesScreenWidgetModel> {
  const CategoriesWidget(super.wmFactory, {super.key});

  @override
  Widget build(ICategoriesScreenWidgetModel wm) {
    if (kIsWeb) {
      final meta = MetaSEO();
      meta.ogTitle(ogTitle: wm.locale.categories);
      meta.description(description: wm.locale.categories);
      meta.keywords(
        keywords: 'Categories, Catalog, Каталог, Категории',
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 48,
        centerTitle: true,
        title: Text(
          wm.locale.categories.toUpperCase(),
          style: AppTypography.montserrat18w700,
          semanticsLabel: 'Page Title: ${wm.locale.categories.toUpperCase()}',
        ),
        leading: const SizedBox.shrink(),
      ),
      body: _CategiriesView(wm: wm),
    );
  }
}

class _CategiriesView extends StatelessWidget {
  const _CategiriesView({super.key, required this.wm});
  final ICategoriesScreenWidgetModel wm;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: SizedBox(
        height: size.height - 60,
        child: EntityStateNotifierBuilder(
          listenableEntityState: wm.categoriesState,
          builder: (context, categories) {
            if (categories == null || categories.isEmpty) {
              return Center(
                child: Text(
                  wm.locale.emtpyCatalog,
                  style: AppTypography.montserrat14w600,
                ),
              );
            }
            return _CategoriesList(
              categories: categories,
              selectCategory: wm.selectCategory,
              size: size,
            );
          },
          loadingBuilder: (context, categories) {
            if (categories == null || categories.isEmpty) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            }
            return _CategoriesList(
              categories: categories,
              selectCategory: wm.selectCategory,
              size: size,
            );
          },
        ),
      ),
    );
  }
}

class _CategoriesList extends StatelessWidget {
  final List<String> categories;
  final Function(String) selectCategory;
  final Size size;
  const _CategoriesList({
    super.key,
    required this.categories,
    required this.selectCategory,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Categories List',
      child: ListView.separated(
        itemBuilder: (context, index) {
          final category = categories[index];
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => selectCategory(category),
            child: Semantics(
              label: category,
              child: SizedBox(
                height: 48,
                width: size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          category.toTitleCase(),
                          style: AppTypography.montserrat16w600,
                        ),
                      ),
                      const Icon(
                        Icons.arrow_forward_ios,
                        size: 18,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const Divider(),
        itemCount: categories.length,
      ),
    );
  }
}
