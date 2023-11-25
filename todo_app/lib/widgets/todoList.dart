import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models%20&%20providers/todos.dart';

class TodoList extends StatefulWidget {
  const TodoList({Key? key});

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  @override
  Widget build(BuildContext context) {
    var todoList = Provider.of<Todos>(context).todoList;
    Function checkBoxHandler = Provider.of<Todos>(context).checkBoxHandler;
    var selectedDate = Provider.of<Todos>(context).getSelectedDate;
    var filteredList =
        todoList.where((todo) => todo.date == selectedDate).toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.5,
      child: filteredList.isEmpty
          ? Center(
              child: Text(
                'No Todos!',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            )
          : ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 15,
                  color: Colors.white70,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.015),
                    child: Row(
                      children: [
                        Transform.scale(
                          scale: MediaQuery.of(context).size.height * 0.0015,
                          child: Checkbox(
                            shape: RoundedRectangleBorder(
                              side: MaterialStateBorderSide.resolveWith(
                                (states) => const BorderSide(
                                    color: Colors.white, width: 1),
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(5),
                              ),
                            ),
                            checkColor: Colors.white,
                            activeColor: Colors.black,
                            value: todoList[index].isCompleted,
                            onChanged: (bool? value) {
                              setState(() {
                                checkBoxHandler(filteredList[index]);
                              });
                            },
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(
                              MediaQuery.of(context).size.height * 0.015),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                filteredList[index].title,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Colors.black,
                                        fontSize:
                                            MediaQuery.of(context).size.height *
                                                0.016),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.015,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  child: Text(
                                    todoList[index].shortNote,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
