import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishalcheck/mainscreen/Time_Table/timeTableWidget.dart';
import 'package:vishalcheck/mainscreen/Time_Table/time_table_provider.dart';


class RoutineListWidget extends StatefulWidget {
  @override
  _RoutineListWidgetState createState() => _RoutineListWidgetState();
}

class _RoutineListWidgetState extends State<RoutineListWidget>
    with TickerProviderStateMixin {
  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoutineProvider>(context);
    final routines = provider.routine1;
    return routines.isEmpty
        ? Center(
            child: Text(
              'No todos.',
                    style: TextStyle(fontSize: 20),
            ),
          )
        : AnimatedList(
            key: key,
            
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.all(8),
            initialItemCount: routines.length,
            itemBuilder: (context, index, animation) {
              final routined = routines[index];

              return RoutineWidget(
                animation: animation,
                item: routined,
              );
            },
          );
  }
}
