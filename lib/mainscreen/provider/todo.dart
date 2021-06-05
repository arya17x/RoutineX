import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:vishalcheck/mainscreen/Task_list.dart';
import 'package:vishalcheck/mainscreen/firebaseapi/firebase_api.dart';

class TodosProvider extends ChangeNotifier {
  List<Todo> _todos = [];
  List<Todo> donetodo = [];
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> getCurrentUID() async {
    final User user = await auth.currentUser;
    final String uid = user.uid;
    return uid;
  }   

  Future getCurrentUser() async {
    return await auth.currentUser;
  }

  Future<String> getCurrentId() async {
    //_uid = uid;

    var uid = auth.currentUser.uid;

    return uid;
  }

  List<Todo> get todos => _todos.where((todo) => todo.isDone == false).toList();

  List<Todo> get todosCompleted =>
      _todos.where((todo) => todo.isDone == true).toList();
  notifyListeners();

  void setTodos(List<Todo> todos) =>
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _todos = todos;
        notifyListeners();
      });

  void addTodo(Todo todo) => FirebaseApi.createTodo(todo);

  void removeTodo(Todo todo) => FirebaseApi.deleteTodo(todo);

  bool toggleTodoStatus(Todo todo) {
    todo.isDone = !todo.isDone;
    FirebaseApi.updateTodo(todo);

    return todo.isDone;
  }

  void updateTodo(Todo todo, String title, String description) {
    todo.task = title;

    FirebaseApi.updateTodo(todo);
  }
}
