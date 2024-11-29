import 'package:intl/intl.dart';

class FormattedText {
  static String formattedAmount(double amount) {
    final formattor = NumberFormat('#,##0');
    return "\u{20B9} ${formattor.format(amount)}";
}

  static String formatDate(String dateString) {

    if (dateString != "") {
      DateFormat inputFormat = DateFormat('dd-MM-yyyy');
      DateTime date = inputFormat.parse(dateString);
      DateFormat outputFormat = DateFormat('dd MMM yy');
      return outputFormat.format(date);
    } else {
      return "";
    }
  }
}