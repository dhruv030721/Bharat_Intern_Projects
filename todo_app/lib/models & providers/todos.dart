import 'package:flutter/material.dart';
import 'package:todo_app/models%20&%20providers/todo.dart';

class Todos with ChangeNotifier {
  List<Todo> todos = [];
  DateTime? selectedDate;

  void addTodo(Todo todo) {
    todos.add(todo);
    notifyListeners();
  }

  List<Todo> get TodoList {
    return [...todos];
  }

  bool checkBoxHandler(Todo todo) {
    if (todo.isCompleted) {
      notifyListeners();
      return todo.isCompleted = false;
    } else {
      notifyListeners();
      return todo.isCompleted = true;
    }
  }

  void dateHandle(DateTime? date) {
    selectedDate = date;
    notifyListeners();
  }

  void removeTodo(Todo todo) {
    todos.remove(todo);
    notifyListeners();
  }

  void selectedDateHandle(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }

  DateTime? get getSelectedDate {
    return selectedDate;
  }
}
