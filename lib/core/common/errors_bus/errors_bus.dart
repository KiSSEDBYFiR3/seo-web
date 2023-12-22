import 'package:rxdart/rxdart.dart';

abstract interface class IErrorsBus {
  void addException(Exception exception);

  BehaviorSubject<Exception> get errorStream;

  void dispose();
}

final class ErrorsBus implements IErrorsBus {
  ErrorsBus();

  @override
  void addException(Exception exception) {
    _errorStream.add(exception);
  }

  @override
  BehaviorSubject<Exception> get errorStream => _errorStream;

  final BehaviorSubject<Exception> _errorStream = BehaviorSubject();

  @override
  void dispose() {
    errorStream.close();
    _errorStream.close();
  }
}
