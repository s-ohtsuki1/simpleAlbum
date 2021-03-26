import 'package:intl/intl.dart';

class DateUtil {}

String dateFormat(DateTime date) {
  return DateFormat('yyyy/MM/dd').format(date);
}
