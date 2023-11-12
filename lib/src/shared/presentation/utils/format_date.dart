import 'package:intl/intl.dart';

class FormatDate {
  static DateTime format(String date) => DateFormat('dd/MM/yyyy').parse(date);
}
