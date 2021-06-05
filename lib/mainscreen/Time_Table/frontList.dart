import 'package:meta/meta.dart';

class FrontList {
  final String routine;
  final String faculty;
  final String room;
  const FrontList({
    @required this.routine,
    @required this.faculty,
    @required this.room,

  });
  static FrontList fromJson(Map<String, dynamic> json) =>
      FrontList(
        routine: json['routine'],
        faculty:json['faculty'],
        room:json['room']

        );
}