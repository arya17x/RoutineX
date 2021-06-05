import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vishalcheck/mainscreen/Time_Table/routine_list.dart';

class RoutineWidget extends StatelessWidget {
  final RoutineLists item;
  final Animation animation;
  const RoutineWidget(
      {@required this.item,
      @required this.animation,
      //     @required this.onClicked,
      Key key})
      : super(key: key);
  @override
  Widget build(BuildContext context) => ScaleTransition(
      scale: animation,
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
        child: Stack(
          children: [
            Container(
              height: ScreenUtil().setHeight(400),
              decoration: BoxDecoration(
                 color: Color(0xff213BD0),
                  borderRadius: BorderRadius.circular(45)),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(18, 15, 18, 15),
                child:Text(item.routine,
                    style:GoogleFonts.lato(
                      decoration: TextDecoration.none,
                      fontSize:22,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    )
                    
                    
                    
                    
                    )),
            Padding(
                padding: EdgeInsets.fromLTRB(15, 75, 45, 10),
                child: Row(
                  children: [
                    Container(
                        height: ScreenUtil().setHeight(150),
                        width: ScreenUtil().setWidth(350),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(45)),
                        child: Center(
                          child: Text(item.room,
                          style:GoogleFonts.lato(
                            decoration: TextDecoration.none,
                            fontSize:24,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          )
                          
                          
                          
                          
                          ),
                        )),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:12.0),
                            child: Text(item.faculty,style:GoogleFonts.lato(
                              fontSize:16,
                              decoration: TextDecoration.none,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange,
                              )),
                          ),
                        )
                  ],
                )),
          ],
        ),
      ));
}
