import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:seo_web/core/navigation/app_router.dart';

@RoutePage(name: 'HomeRoute')
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      lazyLoad: false,
      routes: const [
        CatalogTab(
          children: [
            CatalogRoute(),
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
      bottomNavigationBuilder: (context, tabsRouter) => CupertinoTabBar(
        backgroundColor: Colors.white,
        height: kBottomNavigationBarHeight - 12,
        inactiveColor: Colors.black,
        activeColor: const Color(0xff322cfe),
        currentIndex: tabsRouter.activeIndex,
        onTap: (value) {
          if (tabsRouter.activeIndex != value) {
            tabsRouter.setActiveIndex(value);
            return;
          }

          final childRouter = tabsRouter.childControllers[value];

          if (childRouter is StackRouter) {
            childRouter.popUntilRoot();
          }
        },
        border: const Border(
          top: BorderSide(
            color: Colors.transparent,

            width: 0.0, // 0.0 means one physical pixel
          ),
        ),
        items: [
          _BottomNavigationBarItem(
            icon: Icons.list,
          ),
          _BottomNavigationBarItem(
            icon: Icons.shopping_cart_checkout_rounded,
          ),
          _BottomNavigationBarItem(
            icon: Icons.favorite,
          ),
        ],
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
