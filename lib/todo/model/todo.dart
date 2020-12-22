import 'package:intl/intl.dart';

class ToDo {
  String title;
  DateTime date;
  int importance;// 0, 1, 2
  String docId;
  ToDo(this.title, this.date, this.importance, {this.docId});

  @override
  String toString() {
    return title + ': ' + DateFormat('dd/MM/yyyy, hh:mm a').format(date);
  }


  static int compare(ToDo b, ToDo a) {
    if (a.date.isBefore(b.date)) return 1;
    else if (a.date.isAfter(b.date)) return -1;
    return a.importance - b.importance;
  }
}