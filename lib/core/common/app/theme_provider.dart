import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeProvider extends StatelessWidget {
  final Widget child;
  const ThemeProvider({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ValueNotifier<ThemeMode>>(
      create: (context) => ValueNotifier(ThemeMode.system),
      child: child,
    );
  }
}
