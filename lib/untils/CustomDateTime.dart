// ignore_for_file: file_names

import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  return DateFormat('dd MMMM yyyy').format(date);
}

String formatTime(DateTime date) {
  return DateFormat('hh:mm:ss a').format(date);
}
