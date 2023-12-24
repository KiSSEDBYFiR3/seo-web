// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Add to Cart`
  String get addToCart {
    return Intl.message(
      'Add to Cart',
      name: 'addToCart',
      desc: '',
      args: [],
    );
  }

  /// `Go to Cart`
  String get toCart {
    return Intl.message(
      'Go to Cart',
      name: 'toCart',
      desc: '',
      args: [],
    );
  }

  /// `Catalog`
  String get catalog {
    return Intl.message(
      'Catalog',
      name: 'catalog',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message(
      'Cart',
      name: 'cart',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message(
      'Favorites',
      name: 'favorites',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `Go to Catalog`
  String get toCatalog {
    return Intl.message(
      'Go to Catalog',
      name: 'toCatalog',
      desc: '',
      args: [],
    );
  }

  /// `There is nothing in your cart yet`
  String get emtpyCart {
    return Intl.message(
      'There is nothing in your cart yet',
      name: 'emtpyCart',
      desc: '',
      args: [],
    );
  }

  /// `There is nothing here yet`
  String get emtpyFavorites {
    return Intl.message(
      'There is nothing here yet',
      name: 'emtpyFavorites',
      desc: '',
      args: [],
    );
  }

  /// `There is nothing here yet`
  String get emtpyCatalog {
    return Intl.message(
      'There is nothing here yet',
      name: 'emtpyCatalog',
      desc: '',
      args: [],
    );
  }

  /// `Sort`
  String get sortProduct {
    return Intl.message(
      'Sort',
      name: 'sortProduct',
      desc: '',
      args: [],
    );
  }

  /// `Ascending price`
  String get ascPrice {
    return Intl.message(
      'Ascending price',
      name: 'ascPrice',
      desc: '',
      args: [],
    );
  }

  /// `Descending price`
  String get dscPrice {
    return Intl.message(
      'Descending price',
      name: 'dscPrice',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
