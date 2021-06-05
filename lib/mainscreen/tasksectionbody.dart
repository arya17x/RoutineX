import 'package:flutter/material.dart';
import 'package:vishalcheck/mainscreen/Task_list.dart';
import 'package:vishalcheck/mainscreen/TodoStack.dart';
import 'package:vishalcheck/mainscreen/TodoWidget.dart';
import 'package:vishalcheck/mainscreen/provider/todo.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishalcheck/mainscreen/mainpageapp.dart';
import 'package:vishalcheck/mainscreen/taskDone.dart';

class TodoListWidget extends StatefulWidget {
  @override
  _TodoListWidgetState createState() => _TodoListWidgetState();
}

class _TodoListWidgetState extends State<TodoListWidget>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;
  final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todos;
    // AnimationController _controller;
    // Animation<double> _animation;

    return todos.isEmpty
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
            initialItemCount: todos.length,
            itemBuilder: (context, index, animation) {
              final todo = todos[index];

              return TodoWidget(
                animation: animation,
                item: todo,
              );
            },
          );
  }
}
