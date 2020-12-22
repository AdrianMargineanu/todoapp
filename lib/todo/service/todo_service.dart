import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/todo/model/todo.dart';

class ToDoService {
  /* static List<ToDo> list=[
    new ToDo('Plimba cainele', new DateTime(2020,12,1,12), 0),
    new ToDo('Du gunoiul', new DateTime(2020,12,1,13),1),
    new ToDo('Du-te la magazin', new DateTime(2020,12,1,15), 2),
    new ToDo('Fa un omulet de zapada', new DateTime(2020,12,1,18), 0),
    new ToDo('Îmbodobește bradul de Crăciun', new DateTime(2020,12,1,12), 0),
    new ToDo('Curatenie in camera', new DateTime(2020,12,1,17), 1),
    new ToDo('Curățarea litierei', new DateTime(2020,12,1,16), 2),
    new ToDo('Joc de dame cu profesorii', new DateTime(2020,12,1,18), 0),
    new ToDo('Curatirea terenului de zapada', new DateTime(2020,12,3,10), 1),
    new ToDo('Compleateaza aceasta lista', new DateTime(2020,12,1,10),1),
    new ToDo('Repara laptopul', new DateTime(2020,12,3,20), 2),
    new ToDo('Participa la workshop', new DateTime(2020,12,1,10), 2),
    new ToDo('Backup la hardisk', new DateTime(2020,12,1,19), 1),
    new ToDo('Instalare Flutter', new DateTime(2020,12,1,10), 2),
    new ToDo('Familiarizat cu Dart', new DateTime(2020,12,1,10), 1),
  ];*/

  FirebaseFirestore _cloud = FirebaseFirestore.instance;

  ToDoService();

  void editToDo(ToDo toDo, String docId) {
    final doc = _cloud.collection('list_of_to_do').doc(docId);
    doc.update({
      'title': toDo.title,
      'date': Timestamp.fromDate(toDo.date),
      'importance': toDo.importance,
    });
  }

  Future<List<ToDo>> getList() async {
    final listOfDocuments = await _cloud.collection('list_of_to_do').get();
    List<ToDo> list = [];
    for (int i = 0; i < listOfDocuments.docs.length; i++) {
      var e = listOfDocuments.docs[i];
      list.add(
          ToDo(e.data()['title'], e.data()['date'].toDate(), e.data()['importance'], docId: e.id));
    }
    print("getlist length = " + list.length.toString() + "\n");
    return list;
  }

  Future<void> addToDo(ToDo toDo) async {
    DocumentReference ref = await _cloud.collection('list_of_to_do').add({
      'title': toDo.title,
      'date': Timestamp.fromDate(toDo.date),
      'importance': toDo.importance,
    });
    toDo.docId = ref.id;
  }

  Future<void> deleteToDo(List<ToDo> list) async {
    for (ToDo toDo in list) {
      final doc = _cloud.collection('list_of_to_do').doc(toDo.docId);
      await doc.delete();
    }
  }
}
