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
    Function removeTodoHandler = Provider.of<Todos>(context).removeTodo;
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
                return Dismissible(
                  key: Key(filteredList[index].title),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(
                            right: MediaQuery.of(context).size.width * 0.1),
                        child: Icon(
                          Icons.delete_forever_rounded,
                          color: Colors.white,
                          size: MediaQuery.of(context).size.height * 0.05,
                        ),
                      ),
                    ),
                  ),
                  onDismissed: (direction) {
                    removeTodoHandler(filteredList[index]);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.white,
                        content: Text(
                          '${filteredList[index].title} todo removed!',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: Colors.black),
                        )));
                  },
                  child: Card(
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
                              value: filteredList[index].isCompleted,
                              onChanged: (bool? value) {
                                checkBoxHandler(filteredList[index]);
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
                                  'Time : ${filteredList[index].time}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(color: Colors.black),
                                ),
                                SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                ),
                                Text(
                                  filteredList[index].title,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.019),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.015,
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    alignment: WrapAlignment.start,
                                    children: filteredList[index].tags.map(
                                      (tag) {
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                              right: 5, bottom: 5),
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              color: Colors.black,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(10),
                                              ),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 5),
                                              child: Text(
                                                tag,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ).toList(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
