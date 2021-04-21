import 'package:intl/intl.dart';

class DateUtil {
  static String dateFormat(DateTime date) {
    return DateFormat('yyyy/MM/dd').format(date);
  }
}
