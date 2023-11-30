import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models%20&%20providers/todos.dart';

class DynamicCalendar extends StatefulWidget {
  const DynamicCalendar({super.key});

  @override
  State<DynamicCalendar> createState() => _DynamicCalendarState();
}

class _DynamicCalendarState extends State<DynamicCalendar> {
  @override
  Widget build(BuildContext context) {
    var dateaHandler = Provider.of<Todos>(context, listen: false).dateHandle;
    return EasyDateTimeLine(
      initialDate: DateTime.now(),
      onDateChange: (selectedDate) {
        dateaHandler(selectedDate);
      },
      headerProps: const EasyHeaderProps(
        monthPickerType: MonthPickerType.switcher,
        showSelectedDate: false,
      ),
      dayProps: const EasyDayProps(
        dayStructure: DayStructure.dayStrDayNum,
        inactiveDayStyle: DayStyle(
          dayStrStyle: TextStyle(color: Colors.white),
          dayNumStyle: TextStyle(color: Colors.white),
        ),
        activeDayStyle: DayStyle(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.grey,
                Colors.black,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
