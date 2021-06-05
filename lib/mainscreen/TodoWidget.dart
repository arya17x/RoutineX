import 'package:flutter/material.dart';
import 'package:vishalcheck/mainscreen/Task_list.dart';
import 'package:vishalcheck/mainscreen/provider/todo.dart';
import 'package:vishalcheck/mainscreen/utils.dart';
import 'package:provider/provider.dart';

class TodoWidget extends StatelessWidget {
  final Todo item;
  final Animation animation;
  // final VoidCallback onClicked;
  const TodoWidget(
      {@required this.item,
      @required this.animation,
      //     @required this.onClicked,
      Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: animation,
        child: Container(
          //   height: 45,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white,
          ),
          child: ListTile(
            contentPadding: EdgeInsets.only(left: 10),
            leading: Checkbox(
              activeColor: Theme.of(context).primaryColor,
              checkColor: Colors.white,
              value: item.isDone,
              onChanged: (_) {
                final provider =
                    Provider.of<TodosProvider>(context, listen: false);
                final isDone = provider.toggleTodoStatus(item);
                // isDone?:provider.removeTodo(item);

                Utils.showSnackBar(
                  context,
                  isDone ? 'Task completed' : 'Task marked incomplete',
                );
              },
            ),
            title: Text(item.task, style: TextStyle(fontSize: 20)),
            // trailing: IconButton(
            //    icon: Icon(Icons.check_circle, color: Colors.green, size: 32),
            //    onPressed: onClicked,
          ),
        ),
      );
}
