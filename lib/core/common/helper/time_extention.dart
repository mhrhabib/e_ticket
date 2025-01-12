import 'package:intl/intl.dart';

extension DateTimeFormatting on String {
  String toFormattedDate({String format = 'dd/MMM/yyyy, hh:mm a'}) {
    try {
      DateTime parsedDate = DateTime.parse(this);
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return "Invalid date"; // Return an error message if parsing fails
    }
  }

  String toFormattedDDate({String format = 'dd/MMM/yyyy'}) {
    try {
      DateTime parsedDate = DateTime.parse(this);
      return DateFormat(format).format(parsedDate);
    } catch (e) {
      return "Invalid date"; // Return an error message if parsing fails
    }
  }
}
