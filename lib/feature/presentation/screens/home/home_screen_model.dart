import 'package:elementary/elementary.dart';
import 'package:seo_web/core/common/errors_bus/errors_bus.dart';

abstract interface class IHomeModel extends ElementaryModel {
  IErrorsBus get errorsBus;
}

final class HomeModel extends ElementaryModel implements IHomeModel {
  @override
  final IErrorsBus errorsBus;

  HomeModel({
    required this.errorsBus,
  });
}
