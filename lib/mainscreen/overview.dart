import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vishalcheck/mainscreen/Time_Table/Listofdata.dart';
import 'package:vishalcheck/mainscreen/Time_Table/frontList.dart';
import 'package:vishalcheck/mainscreen/Time_Table/frontProvider.dart';
import 'package:vishalcheck/mainscreen/Time_Table/frontWidget.dart';
import 'package:vishalcheck/mainscreen/Time_Table/full_routine.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routineListWidget.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_firebase.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_list.dart';
import 'package:vishalcheck/mainscreen/Time_Table/time_table_provider.dart';
import 'package:indexed_list_view/indexed_list_view.dart';

class Overview extends StatefulWidget {
  const Overview({Key key}) : super(key: key);

  @override
  _OverviewState createState() => _OverviewState();
}

class _OverviewState extends State<Overview> {
  var controller = IndexedScrollController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<RoutineProvider>(context);
    final routines = provider.routine1;
    return Column(
      children: [
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            child: Row(children: [
              Padding(
                padding: const EdgeInsets.only(right: 14.0),
                child: Container(
                    margin: EdgeInsets.only(left: 18),
                    height: ScreenUtil().setHeight(600),
                    width: ScreenUtil().setWidth(800),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.red,
                        )
                      ],
                      borderRadius: BorderRadius.circular(45),
                      color: Color(0xff282C35),
                    ),
                 //   child:
                    
                    /* StreamBuilder<List<RoutineLists>>(
                        stream: RoutineApi.readRoutine(),
                        builder: (context, snapshot) {
                          final routined = routines[0];
                          switch (snapshot.connectionState) {
                            case ConnectionState.waiting:
                              return Center(
                                  child: CircularProgressIndicator(
                                      backgroundColor: Colors.white));
                            default:
                              if (snapshot.data == null) {
                                return buildText('Waiting');
                              } else {
                                final routine1 = snapshot.data;

                                final provider =
                                    Provider.of<RoutineProvider>(context);
                                provider.setRoutine(routine1);
                                return IndexedListView.builder(
                                  controller: controller,
                                  physics: BouncingScrollPhysics(),
                                  maxItemCount: 1,
                                  itemBuilder: (
                                    context,
                                    index
                                    ,
                                  ) {
                                    final routined = routines[controller.jumpToIndex(10000)];

                                    return FrontWidget(item: routined);
                                  },
                                );
                              }
                          }
                        })*/),
              ),
              SizedBox(width: 16),
              Container(
                margin: EdgeInsets.only(right: 18),
                height: ScreenUtil().setHeight(600),
                width: ScreenUtil().setWidth(800),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                    )
                  ],
                  borderRadius: BorderRadius.circular(45),
                  color: Color(0xff282C35),
                ),
                child: Container(
                  height: 20,
                  width: 35,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.red,
                    elevation: 10,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Container(
                margin: EdgeInsets.only(right: 18),
                height: ScreenUtil().setHeight(600),
                width: ScreenUtil().setWidth(800),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red,
                    )
                  ],
                  borderRadius: BorderRadius.circular(45),
                  color: Color(0xff282C35),
                ),
            //    child:ElevatedButton(child: Text('arya'),onPressed:,)
              ),
            ])),
        /*  Container(
            height: ScreenUtil().setHeight(600),
            child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.only(left: 15, right: 6),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Stack(children: [
                    Container(
                      margin: EdgeInsets.only(right: 18),
                      height: ScreenUtil().setHeight(600),
                      width: ScreenUtil().setWidth(800),
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.red,
                          )
                        ],
                        borderRadius: BorderRadius.circular(45),
                        color: Color(0xff282C35),
                      ),
                    ),*/
        /*     Padding(
                        padding: const EdgeInsets.only(top: 100.0, left: 18),
                        child: StreamBuilder<List<RoutineLists>>(
                            stream: RoutineApi.readRoutine(),
                            builder: (context, snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.waiting:
                                  return Center(
                                      child: CircularProgressIndicator(
                                          backgroundColor: Colors.white));
                                default:
                                  if (snapshot.data == null) {
                                    return buildText('Waiting');
                                  } else {
                                    final routine1 = snapshot.data;

                                    final provider =
                                        Provider.of<RoutineProvider>(context);
                                    provider.setRoutine(routine1);
                                    return Text("gg");
                                  }
                              }
                            }))*/
        /*         ]);
                })
            // TaskPage(),
            ),*/
        SizedBox(height: 30),
        GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => FullRoutine())),
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Container(
                  padding: const EdgeInsets.only(left: 50, right: 50),
                  height: ScreenUtil().setHeight(140),
                  decoration: BoxDecoration(
                    color: Color(0xff213BD0),
                    borderRadius: BorderRadius.circular(45),
                  ),
                  child: Center(
                    child: Text("See Your Full Routine",
                        style: GoogleFonts.lato(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  )),
            )),
      ],
    );
  }

  buildText(String s) {
    Text(
      s,
      style: TextStyle(fontSize: 15),
    );
  }
}
