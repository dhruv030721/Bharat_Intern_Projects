import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models%20&%20providers/todo.dart';
import 'package:todo_app/models%20&%20providers/todos.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _newTaskController = TextEditingController();
  final _tagController = TextEditingController();
  bool _isDateChosen = false;
  var time;
  DateTime? _selectedDate;

  void _addTodo() {
    final newTask = _newTaskController.text;
    final newTag = _tagController.text;
    time = DateTime.now().toIso8601String().substring(11, 19);
    final List<String> tags =
        newTag.split(',').map((tag) => tag.trim()).toList();
    final newTodo = Todo(
        date: _selectedDate,
        title: newTask,
        tags: tags,
        time: time,
        isCompleted: false);
    Provider.of<Todos>(context, listen: false).addTodo(newTodo);
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
                    primary: Colors.black, // header background color
                    onPrimary: Colors.white, // header text color
                    onSurface: Colors.black, // body text color
                  ),
                  textButtonTheme: TextButtonThemeData(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // button text color
                    ),
                  ),
                ),
                child: child!,
              );
            },
            context: context,
            initialDate: _selectedDate ?? DateTime.now(),
            firstDate: DateTime(2023),
            lastDate: DateTime(2024))
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
        _isDateChosen = true;
      });
    });
  }

  Widget InputField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.words,
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
        labelStyle: const TextStyle(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(50)),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.grey,
              Colors.black.withOpacity(0.9),
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(MediaQuery.of(context).size.height * 0.05),
          child: Form(
              child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.circle,
                    size: MediaQuery.of(context).size.height * 0.013,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.03,
                  ),
                  Text(
                    'Add Todo',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontSize: MediaQuery.of(context).size.height * 0.025,
                        color: Colors.black),
                  ),
                ],
              ),
              InputField('New Task', _newTaskController),
              InputField('Task Tag', _tagController),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                '*Note : Add tags comma separeted',
                style: TextStyle(color: Colors.red.withOpacity(0.8)),
              ),
              Container(
                height: 60,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _isDateChosen
                            ? DateFormat().add_yMMMEd().format(_selectedDate!)
                            : 'No date chosen!',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                    TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          'Choose Date',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.grey),
                        )),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.05,
                child: ElevatedButton(
                  onPressed: () {
                    _addTodo();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.white,
                        content: Text(
                          'Todo Added!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        )));
                  },
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Colors.grey),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20))))),
                  child: Text(
                    'Add',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }
}
