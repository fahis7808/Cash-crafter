import 'package:intl/intl.dart';

class FormattedText {
  static String formattedAmount(double amount) {
    final formattor = NumberFormat('#,##0');
    return "\u{20B9} ${formattor.format(amount)}";
}
}