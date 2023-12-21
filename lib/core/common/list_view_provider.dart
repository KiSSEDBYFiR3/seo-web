import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Используется, чтобы на любом экране можно было изменить вид отображения с [ListView] на [GridView] и наоборот
/// Меняет состояние глобально, можно сделать так, чтобы отображалось на каждом экране отдельно, создав для каждого свой скоуп

final listViewProvider = StateProvider<bool>((ref) => true);
