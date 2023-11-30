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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).viewPadding.top * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  HeaderPlate(context, date),
                  const DynamicCalendar(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TodoList(),
                ],
              ),
            ),
          ],
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.01),
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          height: MediaQuery.of(context).size.height * 0.05,
          child: ElevatedButton(
            style: const ButtonStyle(
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)))),
              backgroundColor: MaterialStatePropertyAll(Colors.black),
            ),
            // backgroundColor: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add,
                    size: MediaQuery.of(context).size.height * 0.015),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Text(
                  "Add Todo",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: MediaQuery.of(context).size.height * 0.013),
                ),
              ],
            ),
            onPressed: () => _floatingBtnHandle(context),
          ),
        ),
      ),
    );
  }
}

Widget HeaderPlate(BuildContext context, String date) {
  return Padding(
    padding: EdgeInsets.only(left: MediaQuery.of(context).size.width * 0.08),
    child: Align(
      alignment: Alignment.centerLeft,
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
                ?.copyWith(fontSize: MediaQuery.of(context).size.height * 0.04),
          ),
        ],
      ),
    ),
  );
}
