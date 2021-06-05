import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vishalcheck/mainscreen/Task_list.dart';
import 'package:vishalcheck/mainscreen/edit_todo_page.dart';
import 'package:vishalcheck/mainscreen/firebaseapi/firebase_api.dart';
import 'package:vishalcheck/mainscreen/mainpageapp.dart';
import 'package:vishalcheck/mainscreen/provider/todo.dart';
import 'package:vishalcheck/mainscreen/taskDone.dart';
import 'package:vishalcheck/mainscreen/tasksectionbody.dart';

class TodoStock extends StatefulWidget {
  final User user;
  final Todo todo;
  TodoStock({Key key, this.todo, this.user}) : super(key: key);

  @override
  _TodoStockState createState() => _TodoStockState();
}

class _TodoStockState extends State<TodoStock> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final formKey = new GlobalKey<FormState>();
  final _email = TextEditingController();
  String _uid;

  int currentindex = 0;

  Future<String> getCurrentId() async {
    //_uid = uid;

    _uid = _auth.currentUser.uid;

    return _uid;
  }

  getCurrentUser() async {
    // ignore: await_only_futures
    final User user = await _auth.currentUser;
    final uid = user.uid;
    // Similarly we can get email as well
    //final uemail = user.email;
    return uid;
    //print(uemail);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  onEditingComplete: () => addTodo(),
                  textAlign: TextAlign.justify,
                  textAlignVertical: TextAlignVertical.bottom,
                  cursorColor: Colors.white, //Cursor color change
                  style:
                      TextStyle(color: Colors.white, fontSize: 18, height: 0.85
                          //  height: 0.8
                          //TextFormField title background color change
                          ),
                  controller: _email,
                  keyboardType: TextInputType.text,
                  validator: (val) =>
                      val.length == 0 ? " Write a New Task" : null,
                  decoration: InputDecoration(
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                      hoverColor: Colors.white,
                      labelText: "New Task",
                      suffixIcon: IconButton(
                        onPressed: () => addTodo(),
                        icon: SvgPicture.asset(
                          'assets/feather/arrow-right-circle.svg',
                          color: Colors.white,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: new BorderSide(color: Colors.green),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(
                          color: Color(0xff213BD2),
                          width: 2.0,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      )),
                ),
                SizedBox(
                  height: 45,
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          height: 0,
        ),
        /* Container(
            padding: EdgeInsets.fromLTRB(20, 60, 0, 0),
            child: Text("Tasks",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        SizedBox(
          height: 15,
        ),*/
        Padding(
            padding: const EdgeInsets.only(top: 72.0),
            child: StreamBuilder<List<Todo>>(
              stream: FirebaseApi.readTodos(),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Center(
                        child: CircularProgressIndicator(
                            backgroundColor: Colors.white));
                  default:
                    if (snapshot.hasError) {
                      return buildText('Something Went Wrong Try later');
                    } else {
                      final todos = snapshot.data;

                      final provider = Provider.of<TodosProvider>(context);
                      provider.setTodos(todos);

                      return TodoListWidget();
                    }
                }
              },
            )),
      ],
    );
  }

  void clearText() {
    _email.clear();
  }

  void editTodo(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );

  void addTodo() async {
    final uid = TodosProvider().getCurrentUID();
    final isValid = formKey.currentState.validate();

    if (!isValid) {
      return;
    } else {
      final todo = Todo(
        now: DateTime.now(),
        id: "uid ",
        task: _email.text,
      );

      final provider = Provider.of<TodosProvider>(context, listen: false);
      provider.addTodo(todo);

      // Navigator.of(context).pop();
      clearText();
    }
  }

  buildText(String s) {
    Text(
      s,
      style: TextStyle(fontSize: 15),
    );
  }
}
