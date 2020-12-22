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
  DateTime dateTime;

  @override
  void initState() {
    dateTime = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Add a new ToDo"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: titleController,
                  decoration: InputDecoration(hintText: 'Title'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: importanceController,
                  decoration: InputDecoration(hintText: 'Importance'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 4),
                child: Text(
                  'Current date: ' + DateFormat('dd/MM/yyyy, hh:mm a').format(dateTime),
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () => {
                    DatePicker.showDatePicker(context, onConfirm: (date) {
                      setState(() {
                        dateTime = DateTime(date.year, date.month, date.day, dateTime.hour, dateTime.minute);
                      });
                    }),
                  },
                  child: Text(
                    'Pick a Date',
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: InkWell(
                  onTap: () async {
                    TimeOfDay timeOfDay;
                    timeOfDay = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    setState(() {
                      dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day, timeOfDay.hour, timeOfDay.minute);
                    });
                  },
                  child: Text(
                    'Pick an Hour',
                    style: TextStyle(
                      fontSize: 25,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5.5),
                child: InkWell(
                    onTap: () async {
                      await ToDoService().addToDo(ToDo(
                          titleController.value.text,
                          dateTime,
                          int.parse(importanceController.value.text)));
                      Navigator.pop(context);
                    },
                    child: Text('Save New To Do',
                        style: TextStyle(
                          fontSize: 25,
                          color: Theme.of(context).accentColor,
                        ))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
