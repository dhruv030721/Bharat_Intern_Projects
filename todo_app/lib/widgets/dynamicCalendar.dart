import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models%20&%20providers/todos.dart';

class DynamicCalendar extends StatelessWidget {
  const DynamicCalendar({super.key});

  @override
  Widget build(BuildContext context) {
    var dateaHandler = Provider.of<Todos>(context).selectedDateHandle;
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
