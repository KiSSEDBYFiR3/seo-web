import 'dart:async';

import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:seo_web/core/exception/app_exceptions.dart';
import 'package:seo_web/feature/presentation/screens/home/home_screen.dart';
import 'package:seo_web/feature/presentation/screens/home/home_screen_model.dart';
import 'package:seo_web/generated/l10n.dart';

abstract interface class IHomeScreenWidgetModel
    extends WidgetModel<HomeWidget, IHomeModel> {
  IHomeScreenWidgetModel({
    required IHomeModel model,
  }) : super(model);

  S get locale;
}

IHomeScreenWidgetModel homeScreenWMFactory(BuildContext context) =>
    HomeScreenWidgetModel(model: context.read<IHomeModel>());

final class HomeScreenWidgetModel extends WidgetModel<HomeWidget, IHomeModel>
    implements IHomeScreenWidgetModel {
  HomeScreenWidgetModel({
    required IHomeModel model,
  }) : super(model);

  late final StreamSubscription _errorsSubscription;
  @override
  void initWidgetModel() {
    _errorsSubscription = model.errorsBus.errorStream.listen(_errorsListner);
    super.initWidgetModel();
  }

  @override
  void dispose() {
    _errorsSubscription.cancel();
    super.dispose();
  }

  void _errorsListner(AppException exception) =>
      _showErrorSnackBar(context, exception.message);

  void _showErrorSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        backgroundColor: Theme.of(context).colorScheme.error,
        content: SizedBox(
          child: Center(
            child: Text(
              message,
              style: TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 17,
                color: Theme.of(context).colorScheme.onError,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  S get locale => S.of(context);
}
