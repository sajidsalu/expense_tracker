import 'package:intl/intl.dart';

class DatesUtils {
  DatesUtils._();
  static int get nowMillis => DateTime.now().millisecondsSinceEpoch;

  static String formatDate({int? millis, DateTime? dateTime, String dateFormat = "yy MMM dd hh:mm:ss aaa"}) {
    try {
      dateTime ??= DateTime.fromMillisecondsSinceEpoch(millis ?? DateTime.now().millisecondsSinceEpoch);
      return DateFormat(dateFormat).format(dateTime);
    } catch (error) {
      return '';
    }
  }
}
