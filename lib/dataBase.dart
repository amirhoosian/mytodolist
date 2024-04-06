import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class dataBase {
  List toDoList = [];
  final _myBox = Hive.box('myBox');

  void createinitDate() {
    toDoList = [
      ["ToDoApp", false]
    ];
  }

  void loadData() {
    toDoList = _myBox.get("TODOLIST");
  }

  void updeDate() {
    _myBox.put("TODOLIST", toDoList);
  }
}
