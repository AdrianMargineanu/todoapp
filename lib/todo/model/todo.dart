import 'package:intl/intl.dart';

class ToDo {
  String title;
  DateTime date;
  int importance;// 0 , 1, 2
  String docId;
  ToDo(this.title, this.date, this.importance);

  @override
  String toString() {
    return title + ' until ' + DateFormat('kk:mm').format(date);
  }


  static int compare(ToDo b, ToDo a){
    return a.importance - b.importance;
  }
}