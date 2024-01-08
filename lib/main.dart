import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/core/common/colors/colors.dart';
import 'package:seo_web/core/common/themes.dart';
import 'package:seo_web/core/common/utils/seo_navigation_observer.dart';
import 'package:seo_web/core/di/di.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'dart:developer' as dev;

import 'package:seo_web/core/common/utils/url_strategy_io.dart'
    if (dart.library.html) 'package:flutter_web_plugins/flutter_web_plugins.dart';

import 'package:seo_web/generated/l10n.dart';

void main() async {
  runZonedGuarded(
    _run,
    (error, stack) {
      dev.log(
        error.toString(),
        error: error,
        stackTrace: stack,
      );
    },
  );
}

void _run() async {
  WidgetsFlutterBinding.ensureInitialized();

  setUrlStrategy(PathUrlStrategy());

  final IDiContainer diContainer = DiContainer();

  final app = await diContainer.configureDependencies();
  runApp(app);
}

class App extends StatelessWidget {
  final AppRouter appRouter;
  const App({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ValueNotifier<ThemeMode>>().value;
    return MaterialApp.router(
      color: AppColors.surfaceColor,
      localizationsDelegates: const [
        S.delegate,
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ru'), // Russian
        Locale('en'), // English
      ],
      routerDelegate: appRouter.delegate(
        navigatorObservers: () => [
          SeoNavigationObserver(
            delegate: S.delegate,
          )
        ],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
      routeInformationProvider: appRouter.routeInfoProvider(),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
    );
  }
}
