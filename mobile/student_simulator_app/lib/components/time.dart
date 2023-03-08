import 'package:intl/intl.dart';

String timeToStr(DateTime time) {
  String toStrTime = '';
  if (DateTime.now().year == time.year) {
    if (DateTime.now().month == time.month) {
      if (DateTime.now().day == time.day) {
        if (DateTime.now().hour == time.hour) {
          if (DateTime.now().minute == time.minute) {
            int minuteTo = DateTime.now().minute - time.minute;
            return toStrTime = "${minuteTo.toString()} мин. назад}";
          } else {
            return toStrTime = "меньше минуты назад";
          }
        } else {
          if (60 > time.minute && 0 < time.minute){
          int hourTo = (DateTime.now().hour - time.hour) - 1;
          return toStrTime = "${hourTo.toString()} ч. назад";
          }else{
            int hourTo = DateTime.now().hour - time.hour;
          return toStrTime = "${hourTo.toString()} ч. назад";
          }
        }
      } else {
        if (23 >= time.hour && 0 < time.hour) {
          int dayTo = (DateTime.now().day - time.day) - 1;
          return toStrTime = "${dayTo.toString()} д. назад";
        } else {
          int dayTo = DateTime.now().day - time.day;
          return toStrTime = "${dayTo.toString()} д. назад";
        }
      }
    } else {
      return toStrTime = DateFormat('HH.mm dd.MM.yyyy').format(time);
    }
  } else {
    return toStrTime = DateFormat('HH.mm dd.MM.yyyy').format(time);
  }
}
