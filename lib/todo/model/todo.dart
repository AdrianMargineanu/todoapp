import 'package:intl/intl.dart';

class ToDo {
  String title;
  DateTime date;
  int importance;
  String docId;
  ToDo(this.title, this.date, this.importance, {this.docId});

  @override
  String toString() {
    return title + ': ' + DateFormat('dd/MM/yyyy, hh:mm a').format(date);
  }


  static int compare(ToDo b, ToDo a) {
    if (a.date.day == b.date.day && a.date.month == b.date.month &&
        a.date.year == b.date.year) {
      return a.importance - b.importance;
    } else {
      if (a.date.month == b.date.month && a.date.year == b.date.year) {
        return b.date.day - a.date.day;
      }
      if (a.date.year == b.date.year) {
        return b.date.month - a.date.month;
      }
      return b.date.year - a.date.year;
    }
  }
}