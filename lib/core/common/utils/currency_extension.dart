import 'package:decimal/decimal.dart';
import 'package:decimal/intl.dart';
import 'package:intl/intl.dart';

extension CurrencyExtenstion on Decimal {
  String toPrice() {
    final formatter = NumberFormat.simpleCurrency(
      decimalDigits: 0,
      name: "\$",
      locale: 'en',
    );

    return formatter.format(DecimalIntl(this));
  }
}
