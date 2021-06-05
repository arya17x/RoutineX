import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:vishalcheck/mainscreen/Task_list.dart';
import 'package:vishalcheck/mainscreen/provider/todo.dart';
import 'package:vishalcheck/mainscreen/utils.dart';
import 'package:flutter/material.dart';

class FirebaseApi {
  static Future<String> createTodo(Todo todo) async {
    //final docTodo;
    //  final uid = await
    final _uid = await TodosProvider().getCurrentUID();
    // String uID = todo.id;
    final docTodo = FirebaseFirestore.instance
        .collection('userData')
        .doc(_uid)
        .collection("tasks");

    //todo.id = docTodo.id;
    await docTodo.add(todo.toJson());

    return docTodo.id;
  }

  static Stream<List<Todo>> readTodos() async* {
    /*  FirebaseFirestore.instance.settings =
    Settings(persistenceEnabled: false);*/
    final _uid = await TodosProvider().getCurrentUID();
    yield* FirebaseFirestore.instance
        .collection('userData')
        .doc(_uid)
        .collection('tasks')
        .orderBy(TodoField.now, descending: true)
        .snapshots()
        .transform(Utils.transformer(Todo.fromJson));
  }
  /*=> FirebaseFirestore.instance
     
      .collection('userData')
      .doc()
      .collection('todo')
      .orderBy(TodoField.now, descending: true)
      .snapshots()
      .transform(Utils.transformer(Todo.fromJson));*/

  static Future updateTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.update(todo.toJson());
  }

  static Future deleteTodo(Todo todo) async {
    final docTodo = FirebaseFirestore.instance.collection('todo').doc(todo.id);

    await docTodo.delete();
  }
}
