import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todoapp/todo/model/todo.dart';

class ToDoService {
  FirebaseFirestore _cloud = FirebaseFirestore.instance;

  ToDoService();

  // void editToDo(ToDo newToDo, String docId) {
  //   // docId of the toDo we want to edit
  //   // newToDo is the edited toDo
  //   final doc = _cloud.collection('list_of_to_do').doc(docId);
  //   doc.update({
  //     'title': newToDo.title,
  //     'date': Timestamp.fromDate(newToDo.date),
  //     'importance': newToDo.importance,
  //   });
  // }

  Future<List<ToDo>> getList() async {
    // for getting the list of documents in our database
    final listOfDocuments = await _cloud.collection('list_of_to_do').get();
    List<ToDo> list = [];
    for (int i = 0; i < listOfDocuments.docs.length; i++) {
      var e = listOfDocuments.docs[i];
      list.add(
          ToDo(e.data()['title'], e.data()['date'].toDate(), e.data()['importance'], docId: e.id));
    }
    return list;
  }

  Future<void> addToDo(ToDo toDo) async {
    // toDo is the toDo object we want to add to cloud database
    DocumentReference ref = await _cloud.collection('list_of_to_do').add({
      'title': toDo.title,
      'date': Timestamp.fromDate(toDo.date),
      'importance': toDo.importance,
    });
    toDo.docId = ref.id;
  }

  Future<void> deleteToDo(List<ToDo> list) async {
    // list is the checked toDos we want to delete from our database
    for (ToDo toDo in list) {
      final doc = _cloud.collection('list_of_to_do').doc(toDo.docId);
      await doc.delete();
    }
  }
}
