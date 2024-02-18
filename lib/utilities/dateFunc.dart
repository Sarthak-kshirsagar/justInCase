import 'package:intl/intl.dart';

String getCurrentDate() {
  DateTime now = DateTime.now();
  String day = now.day.toString().padLeft(2, '0');
  String month = now.month.toString().padLeft(2, '0');
  String year = now.year.toString();

  return '$year-$month-$day';
}

String getCurrentMonth() {
  DateTime now = DateTime.now();
  return DateFormat('MMM').format(now); // 'MMM' gives the abbreviated month name
}

String getCurrentYear() {
  DateTime now = DateTime.now();
  String year = now.year.toString();

  return year;
}
