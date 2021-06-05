import 'package:flutter/material.dart';
import 'package:vishalcheck/mainscreen/Time_Table/frontList.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_list.dart';

class FrontProvider extends ChangeNotifier {
  FrontList routineList ;

  DateTime date = DateTime.now();

  FrontList get routine1 => routineList;
  //   .where((routined) => routined.routine == String)

  void setRoutine(FrontList routine1) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        routineList = routine1;
        notifyListeners();
      });

  /*String weekDay() {
    DateTime date = DateTime.now();
    int day = date.weekday;
    String dayWeek = '';
    switch (day) {
      case 1:
        {
          dayWeek = 'Monday';
          break;
        }
      case 2:
        {
          dayWeek = 'Tuesday';
          break;
        }
      case 3:
        {
          dayWeek = 'Wednesday';
          break;
        }
      case 4:
        {
          dayWeek = 'Thursday';
          break;
        }
      case 5:
        {
          dayWeek = 'Friday';
          break;
        }
      case 6:
        {
          dayWeek = 'Saturday';
          break;
        }
      case 7:
        {
          dayWeek = 'Sunday';
          break;
        }
    }
    return dayWeek;
  }*/
}
