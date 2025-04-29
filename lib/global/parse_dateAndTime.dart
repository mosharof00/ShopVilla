import 'package:intl/intl.dart';

class DateTimeUtils {
  static String parseDate(String date) {
    final month = DateFormat('MMMM').format(DateTime.parse(date));
    final day = DateFormat('d').format(DateTime.parse(date));
    final year = DateFormat('y').format(DateTime.parse(date));
    return '$day $month, $year';
  }

  static String parseTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString).toLocal();
    return DateFormat('hh:mm a').format(dateTime);
  }
  static String formatTimeAgo(String dateTime) {
    final now = DateTime.now();
    final difference = now.difference(DateTime.parse(dateTime));

    if (difference.inDays > 8) {
      return DateFormat('MMM dd, yyyy').format(DateTime.parse(dateTime));
    } else if (difference.inDays >= 1) {
      return '${difference.inDays} days ago';
    } else if (difference.inHours >= 1) {
      return '${difference.inHours} hours ago';
    } else if (difference.inMinutes >= 1) {
      return '${difference.inMinutes} minutes ago';
    } else {
      return 'Just now';
    }
  }

}
