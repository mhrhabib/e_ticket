import 'package:intl/intl.dart';

extension DateTimeFormatting on String {
  String toFormattedDate({String format = 'yyyy-MM-dd'}) {
    try {
      DateTime parsedDate = DateTime.parse(this);
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return "Invalid date"; // Return an error message if parsing fails
    }
  }

  String toFormattedDDate({String format = 'dd/MM/yyyy'}) {
    try {
      DateTime parsedDate = DateTime.parse(this);
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return "Invalid date"; // Return an error message if parsing fails
    }
  }
}
