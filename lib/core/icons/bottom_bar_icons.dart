import 'package:flutter/material.dart';

abstract final class BottomBarIcons {
  BottomBarIcons._();

  static const _fontFamily = 'BottomBarIcons';

  static const IconData favorites = IconData(
    0xe900,
    fontFamily: _fontFamily,
  );

  static const IconData catalog = IconData(
    0xe901,
    fontFamily: _fontFamily,
  );

  static const IconData cart = IconData(
    0xe902,
    fontFamily: _fontFamily,
  );

  static const IconData search = IconData(
    0xe903,
    fontFamily: _fontFamily,
  );
}
