import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/core/common/app/theme_provider.dart';
import 'package:seo_web/core/common/themes.dart';
import 'package:seo_web/core/di/di.dart';
import 'package:seo_web/core/navigation/app_router.dart';
import 'dart:developer' as dev;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await diContainer.configureDependencies();

  final app = diContainer.createApp();

  runZonedGuarded(
    () => runApp(
      ThemeProvider(child: app),
    ),
    (error, stack) {
      dev.log(
        error.toString(),
        error: error,
        stackTrace: stack,
      );
    },
  );
}

class App extends StatelessWidget {
  final AppRouter appRouter;
  const App({super.key, required this.appRouter});
  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ValueNotifier<ThemeMode>>().value;
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode,
    );
  }
}
