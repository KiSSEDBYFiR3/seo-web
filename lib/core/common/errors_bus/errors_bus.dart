import 'package:rxdart/rxdart.dart';
import 'package:seo_web/core/exception/app_exceptions.dart';

abstract interface class IErrorsBus {
  void addException(AppException exception);

  BehaviorSubject<AppException> get errorStream;

  void dispose();
}

final class ErrorsBus implements IErrorsBus {
  ErrorsBus();

  @override
  void addException(AppException exception) {
    _errorStream.add(exception);
  }

  @override
  BehaviorSubject<AppException> get errorStream => _errorStream;

  final BehaviorSubject<AppException> _errorStream = BehaviorSubject();

  @override
  void dispose() {
    errorStream.close();
    _errorStream.close();
  }
}
