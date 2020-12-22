import 'package:flutter/material.dart';
import 'package:grouped_checkbox/grouped_checkbox.dart';
import 'package:todoapp/todo/model/todo.dart';
import 'package:todoapp/todo/service/todo_service.dart';
import 'add_new_todo_view.dart';

class ToDoView extends StatefulWidget {
  _ToDoViewState createState() => _ToDoViewState();
}

class _ToDoViewState extends State<ToDoView> {
  List<String> allItemList = [];
  List<String> checkedItemList = [];

  Map<String, ToDo> stringToInstance = Map<String, ToDo>();

  @override
  void initState() {
    // ToDoService.list.sort(ToDo.compare);
    // allItemList = ToDoService.list.map((e) => e.toString()).toList();

    super.initState();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: new ToDoService().getList(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<ToDo> toDos = snapshot.data;
          toDos.sort(ToDo.compare);
          allItemList = toDos.map((e) => e.toString()).toList();

          for (ToDo toDo in toDos) {
            stringToInstance[toDo.toString()] = toDo;
          }

          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => {
                    Navigator.push(context,
                            MaterialPageRoute(builder: (_) => AddToDoView()))
                        .then((value) => setState(() {}))
                  },
                ),
              ],
              // Here we take the value from the MyHomePage object that was created by
              // the App.build method, and use it to set our appbar title.
              title: Text('To Do'),
            ),
            body: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: GroupedCheckbox(
                // disabled: checkedItemList,
                checkedItemList: checkedItemList,
                onChanged: (itemList) {
                  setState(() {
                    checkedItemList = itemList;
                  });
                },
                itemList: allItemList,
                orientation: CheckboxOrientation.VERTICAL,
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                // OPen Dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Alert Delete all items'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                            'Are you sure that you want to delete all checked items from '
                            'the to do list?'),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                child: Text('Back',
                                    style: TextStyle(
                                      color: Theme.of(context).accentColor,
                                    )),
                                onTap: () => {Navigator.pop(context)},
                              ),
                              InkWell(
                                child: Text('Yes',
                                    style: TextStyle(
                                      color: Colors.red,
                                    )),
                                onTap: () async {
                                  Navigator.pop(context);
                                  List<ToDo> deleteItems = [];
                                  for (String e in checkedItemList) {
                                    deleteItems.add(stringToInstance[e]);
                                  }
                                  print(deleteItems[0].docId + "\n");
                                  await ToDoService().deleteToDo(deleteItems);
                                  checkedItemList.clear();
                                  setState(() {});
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: Icon(Icons.delete_forever),
            ),
          );
        });
  }
}
