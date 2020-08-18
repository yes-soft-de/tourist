import 'package:tourists/module_shared/model/date/date.dart';

class TimeFormatter {
  static DateTime getDartDate(Date date) {
    int timeStamp = date.timestamp;
    return new DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
  }
}