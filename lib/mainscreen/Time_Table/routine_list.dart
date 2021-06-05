import 'package:meta/meta.dart';

class RoutineLists {
  final String routine;
  final String faculty;
  final String room;
  const RoutineLists({
    @required this.routine,
    @required this.faculty,
    @required this.room,

  });
  static RoutineLists fromJson(Map<String, dynamic> json) =>
      RoutineLists(
        routine: json['routine'],
        faculty:json['faculty'],
        room:json['room']

        );
}

/*class RoutineLists {
  final String first;
  final String second;
  final String third;
  final String forth;
  final String fifth;
  final String sixth;
  final String seventh;
  final String eighth;

  const RoutineLists({
    @required this.first,
    @required this.second,
    @required this.third,
    @required this.forth,
    @required this.fifth,
    @required this.sixth,
    @required this.seventh,
    @required this.eighth,
  });

  static RoutineLists fromJson(Map<String, dynamic> json) => RoutineLists(
        first: json['first'],
        second: json['Second'],
        third: json['Third'],
        forth: json['Fourth'],
        fifth: json['Fifth'],
        sixth: json['Sixth'],
        seventh: json['Seventh'],
        eighth: json['Eighth'],
      );

/*  Map<String, dynamic> toJson() => {
        'First': first,
        'Secind': second,
        'Third': third,
        'Fourth': forth,
        'Fifth': fifth,
        'Sixth': sixth,
        'Seventh': seventh,
        'Eighth': eighth,
      };*/
}*/
