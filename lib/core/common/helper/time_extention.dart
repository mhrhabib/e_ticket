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

  String toFormattedDDate(String dateString, {String format = 'dd/MM/yyyy, hh:mm:ss'}) {
    try {
      // Parse the input date string to DateTime
      DateTime dateTime = DateTime.parse(dateString);

      // Format the DateTime object using the specified format
      DateFormat formatter = DateFormat(format);
      return formatter.format(dateTime);
    } catch (e) {
      // Handle parsing errors (e.g., invalid date format)
      return 'Invalid Date';
    }
  }
}
