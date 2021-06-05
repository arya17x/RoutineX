import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vishalcheck/mainscreen/Task_list.dart';
import 'package:vishalcheck/mainscreen/TodoWidget.dart';
import 'package:vishalcheck/mainscreen/firebaseapi/firebase_api.dart';
import 'package:vishalcheck/mainscreen/mainpageapp.dart';
import 'package:vishalcheck/mainscreen/provider/todo.dart';

class CompletedListWidget extends StatelessWidget {
  // final Animation animation;
  @override
  Widget build(BuildContext context) {
    final GlobalKey<AnimatedListState> key = GlobalKey<AnimatedListState>();
    final provider = Provider.of<TodosProvider>(context);
    final todos = provider.todosCompleted;

    return todos.isEmpty
        ? Center(
            child: Text(
              'No completed tasks.',
              style: TextStyle(fontSize: 20),
            ),
          )
        : StreamBuilder<List<Todo>>(
            stream: FirebaseApi.readTodos(),
            builder: (context, snapshot) {
              /*       final provider = Provider.of<TodosProvider>(context);
              provider.setTodos(todos);*/

              return AnimatedList(
                key: key,
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.all(16),
                //separatorBuilder: (context, index) => Container(height: 8),
                //  ItemCount: todos.length,
                initialItemCount: todos.length,
                itemBuilder: (context, index, animation) {
                  final todo = todos[index];

                  return TodoWidget(
                    item: todo,
                    animation: animation,
                  );
                },
              );
            });
  }
}

/* child: AnimatedList(
              key: key,
              physics: BouncingScrollPhysics(),
              padding: EdgeInsets.all(16),
              //separatorBuilder: (context, index) => Container(height: 8),
              //  ItemCount: todos.length,
              initialItemCount: todos.length,
              itemBuilder: (context, index, animation) {
                final todo = todos[index];

                return TodoWidget(
                  item: todo,
                  animation: animation,
                );
              },
            ),*/
