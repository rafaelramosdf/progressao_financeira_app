import 'package:intl/intl.dart';

extension ConvertToDouble on String {
  double toDouble() => this != null
      ? double.parse(this.replaceAll('.', '').replaceAll(',', '.'))
      : 0.0;
}

extension DoubleToCurrencyString on double {
  String formatToCurrencyString({
    bool hiddenSymbol = false,
  }) {
    var formatCurrency = NumberFormat.currency(
      locale: "pt_BR",
      decimalDigits: 2,
      symbol: !hiddenSymbol ? "R\$" : "",
    );

    if (this != null) {
      return formatCurrency.format(this);
    } else {
      return formatCurrency.format(0.0);
    }
  }
}
