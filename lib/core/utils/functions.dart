import 'package:intl/intl.dart';

String formatTimeArabic(DateTime dateTime) {
  final DateFormat formatter = DateFormat('hh:mm a', 'ar');
  return formatter.format(dateTime);
}
