import 'package:auto_route/auto_route.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seo_web/core/common/utils/seo_helper.dart';
import 'package:seo_web/core/icons/custom_icons.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:seo_web/feature/presentation/screens/home/home_screen_widget_model.dart';

@RoutePage(name: 'HomeRoute')
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeWidget(homeScreenWMFactory);
  }
}

class HomeWidget extends ElementaryWidget<IHomeScreenWidgetModel> {
  const HomeWidget(super.wmFactory, {super.key});

  @override
  Widget build(IHomeScreenWidgetModel wm) {
    SEOHelper.addTitle(title: 'Seo Web');

    return LayoutBuilder(
      builder: (context, constraints) => AutoTabsScaffold(
        backgroundColor: Colors.white,
        appBarBuilder: (context, tabsRouter) => AppBar(
          leading: const SizedBox.shrink(),
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            systemNavigationBarDividerColor: Colors.white,
            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        lazyLoad: false,
        routes: const [
          CatalogTab(
            children: [
              CategoriesRoute(),
            ],
          ),
          CartTab(
            children: [
              CartRoute(),
            ],
          ),
          FavoritesTab(
            children: [
              FavoritesRoute(),
            ],
          )
        ],
        homeIndex: 0,
        bottomNavigationBuilder: (context, tabsRouter) {
          return constraints.maxWidth <= 550
              ? CupertinoTabBar(
                  backgroundColor: Colors.white,
                  height: kBottomNavigationBarHeight - 12,
                  inactiveColor: Colors.black,
                  activeColor: const Color(0xff322cfe),
                  currentIndex: tabsRouter.activeIndex,
                  onTap: (value) => wm.onNavigationItemTap(value, tabsRouter),
                  border: const Border(
                    top: BorderSide(
                      color: Colors.transparent,

                      width: 0.0, // 0.0 means one physical pixel
                    ),
                  ),
                  items: [
                    _BottomNavigationBarItem(icon: CustomIcons.catalog),
                    _BottomNavigationBarItem(icon: CustomIcons.cart),
                    _BottomNavigationBarItem(icon: CustomIcons.favorites),
                  ],
                )
              : const SizedBox.shrink();
        },
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        floatingActionButtonBuilder: (context, tabsRouter) {
          return constraints.maxWidth >= 550
              ? SizedBox(
                  width: 50,
                  child: NavigationRail(
                    groupAlignment: -0.5,
                    extended: false,
                    backgroundColor: Colors.white,
                    selectedIndex: tabsRouter.activeIndex,
                    destinations: [
                      NavigationRailDestination(
                        label: Text(wm.locale.catalog),
                        icon: const _NavigationBarIcon(
                          icon: CustomIcons.catalog,
                        ),
                      ),
                      NavigationRailDestination(
                        label: Text(wm.locale.cart),
                        icon: const _NavigationBarIcon(
                          icon: CustomIcons.cart,
                        ),
                      ),
                      NavigationRailDestination(
                        label: Text(wm.locale.favorites),
                        icon: const _NavigationBarIcon(
                          icon: CustomIcons.favorites,
                        ),
                      ),
                    ],
                    onDestinationSelected: (value) =>
                        wm.onNavigationItemTap(value, tabsRouter),
                  ),
                )
              : const SizedBox();
        },
      ),
    );
  }
}

class _BottomNavigationBarItem extends BottomNavigationBarItem {
  _BottomNavigationBarItem({
    required IconData icon,
    String label = '',
  }) : super(
          icon: _NavigationBarIcon(
            icon: icon,
          ),
          label: label,
          activeIcon: _NavigationBarIcon(
            icon: icon,
          ),
          backgroundColor: Colors.transparent,
        );
}

class _NavigationBarIcon extends StatelessWidget {
  const _NavigationBarIcon({
    required this.icon,
    Key? key,
  }) : super(key: key);

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Icon(
            icon,
            size: 24,
          ),
        ],
      ),
    );
  }
}
