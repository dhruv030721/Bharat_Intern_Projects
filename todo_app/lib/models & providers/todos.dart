import 'package:flutter/material.dart';
import 'package:todo_app/models%20&%20providers/todo.dart';

class Todos with ChangeNotifier {
  List<Todo> todos = [];
  DateTime? selectedDate;

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  List<Todo> get todoList {
    return [...todos];
  }

  bool checkBoxHandler(Todo todo) {
    if (todo.isCompleted) {
      return todo.isCompleted = false;
    } else {
      return todo.isCompleted = true;
    }
  }

  void selectedDateHandle(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  DateTime? get getSelectedDate {
    return selectedDate;
  }
}
