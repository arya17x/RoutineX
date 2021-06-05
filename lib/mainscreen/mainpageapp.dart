import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vishalcheck/homepage.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:vishalcheck/mainscreen/Time_Table/full_routine.dart';

import 'package:vishalcheck/mainscreen/Time_Table/routine_firebase.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_list.dart';
import 'package:vishalcheck/mainscreen/Time_Table/time_table_provider.dart';
import 'package:vishalcheck/mainscreen/TodoStack.dart';
import 'package:vishalcheck/mainscreen/edit_todo_page.dart';
import 'package:vishalcheck/mainscreen/overview.dart';
import 'package:vishalcheck/mainscreen/provider/todo.dart';
import 'package:vishalcheck/mainscreen/taskDone.dart';
import 'package:vishalcheck/mainscreen/Task_list.dart';
import 'package:vishalcheck/mainscreen/Time_Table/timeTableWidget.dart';

//import 'package:vishalcheck/utils/constants.dart';

class MainPage extends StatefulWidget {
  final Todo todo;
  final User user;
  final String uid;
  //final RoutineLists routine;

  MainPage({
    Key key,
    this.todo,
    this.user,
    this.uid,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final key = GlobalKey<AnimatedListState>();
  final routinelist = RoutineProvider().routine1;
//  final items = List.from(TaskList.shoppingList);

  //

  void inputData() {
    // final User user = _auth.currentUser;

    // here you write the codes to input the data into firestore
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _scaffoldkey = new GlobalKey<ScaffoldState>();

  int _index = 0;
  int currentindex = 0;

  DateTime now = DateTime.now();
  final formKey = new GlobalKey<FormState>();
  final PageController _pageController = PageController();
  // final formKey = new GlobalKey<FormState>();
  // final _email = TextEditingController();

  // final VoidCallback onSignedOut;
  // final String uid;

  Future<HomePage> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/signin');
    return new HomePage();
  }

  Future<String> getCurrentId() async {
    return (await _auth.currentUser).uid;
  }

  String displayName;

  Future userName;
//  String _uid;

  /*Future initUser() async {
    //final User user = (await _auth.signInWithCredential(credential)).user;
    user = await _auth.currentUser;
    setState(() {});
  }*/
  @override
  void initState() {
    super.initState();
    userName = TodosProvider().getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(1080, 2340), allowFontScaling: false);

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
          child: Text("Dashboard"),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 25.0),
            child: SvgPicture.asset(
              'assets/feather/message-circle.svg',
              color: Colors.white,
            ),
          ),
          Padding(
              padding: EdgeInsets.only(right: 25.0),
              child: GestureDetector(
                onTap: () {
                  signOut();
                },
                child: SvgPicture.asset(
                  'assets/feather/log-out.svg',
                ),
              ))
        ],
        backgroundColor: Color(0xff050609),
        elevation: 0.6,
      ),
      backgroundColor: Color(0xff050609),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 15, left: 18),
            child: Container(
              height: ScreenUtil().setHeight(300),
              child: FutureBuilder(
                  future: userName,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return displayUserName(context, snapshot);
                    } else {
                      return CircularProgressIndicator(
                          backgroundColor: Colors.white);
                    }
                  }
                  /*     child: Padding(
                  padding: const EdgeInsets.only(top: 15, left: 18),
                  child: Container(
                    child: Text(
                      daynoon(),
                      style: TextStyle(
                        fontFamily: 'Montserrat',
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                ),*/
                  ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 45,
                  width: 130,
                  child: Center(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _index = 0;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: Text(
                          "Overview",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: 'Montserrat',
                              color: _index == 0
                                  ? Colors.white
                                  : Color(0xff423F5B)),
                        ),
                      ),
                    ),
                  ),
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(45),
                    color: _index == 0 ? Color(0xff213BD0) : Colors.transparent,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                height: 45,
                width: 130,
                child: Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _index = 1;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 18.0),
                      child: Text(
                        "Productivity",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            color:
                                _index == 1 ? Colors.white : Color(0xff423F5B)),
                      ),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(45),
                  color: _index == 1 ? Color(0xff213BD0) : Colors.transparent,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          _index == 0
              ? Overview()
              : //MainTaskPage(),
              GestureDetector(
                  //    onTap: () => editTodo(context, todo),
                  child: Container(
                      padding: EdgeInsets.only(top: 20),
                      height: ScreenUtil().setHeight(1230),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45)),
                          color: Color(0xff282C35)),
                      child: PageView(
                        controller: _pageController,
                        children: [
                          TodoStock(), //container is first page
                          CompletedListWidget(), //it is second page for controller
                        ],
                        onPageChanged: (page) {
                          setState(() {
                            currentindex = page;
                          });
                        },
                      )),
                )
        ],
      ),
      bottomNavigationBar: _index == 0
          ? null
          : BottomNavyBar(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              animationDuration: Duration(milliseconds: 400),
              curve: Curves.easeInCirc,
              backgroundColor: Color(0xff282C35),
              selectedIndex: currentindex,
              onItemSelected: (index) {
                setState(() {
                  currentindex = index;
                  _pageController.jumpToPage(index);
                });
              },
              items: <BottomNavyBarItem>[
                BottomNavyBarItem(
                    icon: Icon(Icons.edit_sharp),
                    title: Text(
                      "Tasks",
                      style: TextStyle(color: Colors.white),
                    ),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey),
                BottomNavyBarItem(
                    icon: Icon(Icons.edit_off),
                    title: Text("Completed"),
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey)
              ],
            ),
    );
  }

  String daynoon() {
    if (now.hour < 12 && now.hour > 4) {
      return ("GoodMorning");
    } else if (now.hour > 12 && now.hour < 16) {
      return ("Good AfterNoon");
    } else {
      return ("Good Evening");
    }
  }

  /*String name() {
    for (final data in user.providerData) {
      if (data?.displayName?.toLowerCase()?.contains('null') == false) {
        displayName = data.displayName;
      }
    }
    // nam1 = _auth.currentUser.displayName;
    // nam1 = widget.user.displayName;
    names = displayName[0].toUpperCase() + displayName.substring(1);
    return names != null ? names : daynoon();
  }*/

  Widget displayUserName(context, snapshot) {
    return Text(
      "${snapshot.data.displayName}, \n" + daynoon(),
      style: TextStyle(
        fontFamily: 'Montserrat',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 40,
      ),
    );
  }

  void editTodo1(BuildContext context, Todo todo) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => EditTodoPage(todo: todo),
        ),
      );
}

Widget buildText(String text) => Center(
      child: Text(
        text,
        style: TextStyle(fontSize: 24, color: Colors.white),
      ),
    );

