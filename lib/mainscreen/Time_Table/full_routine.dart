import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routineListWidget.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_firebase.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_list.dart';
import 'package:vishalcheck/mainscreen/Time_Table/time_table_provider.dart';

class FullRoutine extends StatefulWidget {
  final RoutineLists routined;
  const FullRoutine({Key key, this.routined}) : super(key: key);
  @override
  _FullRoutineState createState() => _FullRoutineState();
}

class _FullRoutineState extends State<FullRoutine> {
  
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<RoutineLists>>(
        stream: RoutineApi.readRoutine(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                  child:
                      CircularProgressIndicator(backgroundColor: Colors.white));
            default:
              if (snapshot.data == null) {
                return buildText('Waiting');
              } else {
                final routine1 = snapshot.data;

                final provider = Provider.of<RoutineProvider>(context);
                provider.setRoutine(routine1);
                return RoutineListWidget();
              }
          }
        });
  }

  Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      );
}
