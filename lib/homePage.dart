import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo/dataBase.dart';
import 'package:todo/dialogbox.dart';
import 'package:todo/todo_tile.dart';

class homePage extends StatefulWidget {
  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final _controller = TextEditingController();
  final _moBox = Hive.box('myBox');
  dataBase db = dataBase();

  @override
  void initState() {
    if (_moBox.get("TODOLIST") == null) {
      db.createinitDate();
    } else {
      db.loadData();
    }
    // TODO: implement initState
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updeDate();
  }

  void cerateNewTask() {
    showDialog(
        context: context,
        builder: (context) {
          return dialogBox(
            controller: _controller,
            onSaved: saveNewTask,
            onCancel: () => Navigator.of(context).pop(),
          );
        });
  }

  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updeDate();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updeDate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Center(child: Text("ToDo")),
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: cerateNewTask,
        backgroundColor: Colors.yellow,
        child: Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDotile(
            taskName: db.toDoList[index][0],
            taskComlited: db.toDoList[index][1],
            onChanged: (value) => {checkBoxChanged(value, index)},
            deletefun: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
