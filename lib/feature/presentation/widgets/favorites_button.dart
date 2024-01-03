// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FavoritesButton extends StatelessWidget {
  final bool isFavorite;
  final VoidCallback onTap;
  const FavoritesButton({
    super.key,
    required this.isFavorite,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Add to favorites button',
      child: GestureDetector(
        onTap: onTap,
        child: SvgPicture.asset(
          'assets/svg/favorite.svg',
          color: isFavorite ? Colors.red : Colors.black,
        ),
      ),
    );
  }
}
