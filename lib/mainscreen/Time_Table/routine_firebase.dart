import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_list.dart';
import 'package:vishalcheck/mainscreen/Time_Table/time_table_provider.dart';
import 'package:vishalcheck/mainscreen/utils.dart';

class RoutineApi {
  static Stream<List<RoutineLists>> readRoutine() {
     DateTime date = DateTime.now();
     int day = date.weekday; 

    return FirebaseFirestore.instance
        .collection('NewRoutine')
        .doc('$day')
        .collection('routine')
        .snapshots()
        .transform(Utils.transformer(RoutineLists.fromJson));
  }
}
