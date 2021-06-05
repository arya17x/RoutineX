import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vishalcheck/mainscreen/Time_Table/frontList.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_list.dart';
import 'package:vishalcheck/mainscreen/utils.dart';

abstract class ListItem {}

class CurrentClass {
  static Stream<FrontList> readRoutines() {
    DateTime date = DateTime.now();
    int day = date.weekday;
    String cT = currentTime();

    return FirebaseFirestore.instance
        .collection('NewRoutine')
        .doc('$day')
        .collection('routine')
        .doc(cT)
        .snapshots()
        .transform(Utils.transformer(FrontList.fromJson));
  }

  static String currentTime() {
    DateTime date = DateTime.now();
    String period;
    if (date.hour == 9 && date.minute <= 55) {
      period = '1';
    } else if (date.hour == 10 && date.minute <= 50) {
      period = '2';
    } else if (date.hour == 11 && date.minute <= 45) {
      period = '3';
      return period;
    } else if (date.hour == 12 && date.minute <= 40) {
      period = '4';
      return period;
    } else if (date.hour == 13 && date.minute <= 35) {
      period = '5';
      return period;
    } else if (date.hour == 14 && date.minute <= 30) {
      period = '6';
      return period;
    } else if (date.hour == 15 && date.minute <= 25) {
      period = '7';
      return period;
    } else if (date.hour == 16 && date.minute <= 20) {
      period = '8';
      return period;
    } else {
      period == '9';
    }

    return period;
  }
}
