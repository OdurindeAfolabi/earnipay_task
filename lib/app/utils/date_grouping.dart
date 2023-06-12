import 'package:intl/intl.dart';


String specialDateTimeFormat(String date) {
  return DateFormat("dd, MMM yyyy")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}
String specialDateTimeFormat2(String date) {
  return DateFormat("dd/MM/yyyy h:mm:ss a")
      .format(DateTime.tryParse(date) ?? DateTime.now());
}

