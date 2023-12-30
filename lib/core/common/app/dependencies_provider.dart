import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/core/di/dependencies.dart';

class DependenciesProvider extends StatelessWidget {
  final Widget child;
  final Dependencies dependencies;
  const DependenciesProvider({
    super.key,
    required this.dependencies,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (context) => dependencies,
        ),
        ChangeNotifierProvider<ValueNotifier<ThemeMode>>(
          create: (context) => ValueNotifier(ThemeMode.system),
          child: child,
        ),
      ],
      child: child,
    );
  }
}
