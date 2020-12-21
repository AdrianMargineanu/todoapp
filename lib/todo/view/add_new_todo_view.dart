import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/todo/model/todo.dart';
import 'package:todoapp/todo/service/todo_service.dart';

class AddToDoView extends StatefulWidget {
  _AddToDoViewState createState() => _AddToDoViewState();
}

class _AddToDoViewState extends State<AddToDoView> {
  final titleController = TextEditingController();
  final importanceController = TextEditingController();
  String dateTimeString;
  DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    dateTime = DateTime.now();
    dateTimeString = DateFormat('kk:mm').format(dateTime);
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(hintText: 'Title'),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: importanceController,
              decoration: InputDecoration(hintText: 'Importance'),
            ),
            Text('Current date $dateTimeString'),
            InkWell(
                onTap: () => {
                      DatePicker.showDatePicker(context, onConfirm: (date) {
                        setState(() {
                          dateTime = date;
                          dateTimeString = DateFormat('kk:mm').format(date);
                        });
                      }),
                    },
                child: Text('Pick a Date',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ))),
            InkWell(
                onTap: () async {
                  await new ToDoService().addToDo(ToDo(titleController.value.text, dateTime, int.parse(importanceController.value.text)));
                  Navigator.pop(context);
                },
                child: Text('Save New To Do',
                    style: TextStyle(
                      color: Theme.of(context).accentColor,
                    ))),
          ],
        ),
      ),
    );
  }
}
