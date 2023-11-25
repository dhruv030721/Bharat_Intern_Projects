import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/widgets/dynamicCalendar.dart';
import 'package:todo_app/widgets/newTodo.dart';
import 'package:todo_app/widgets/todoList.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _floatingBtnHandle(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(50))),
        builder: (_) {
          return const NewTodo();
        });
  }

  @override
  Widget build(BuildContext context) {
    var date = DateFormat('EEEE, d MMMM').format(DateTime.now());

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top * 2),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        Text(
                          'Todo List',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(
                                  fontSize: MediaQuery.of(context).size.height *
                                      0.04),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const DynamicCalendar(),
              const TodoList(),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.02),
        child: FloatingActionButton.extended(
          backgroundColor: Colors.black.withOpacity(0.6),
          label: const Text('Add Todo'),
          elevation: 10,
          icon: const Icon(Icons.add),
          onPressed: () => _floatingBtnHandle(context),
        ),
      ),
    );
  }
}
