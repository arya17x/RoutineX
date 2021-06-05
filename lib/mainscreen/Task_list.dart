import 'package:meta/meta.dart';
import 'package:vishalcheck/mainscreen/utils.dart';

class TodoField {
  static const now = 'createdTime';
}

class Todo {
  String task;
  DateTime now = DateTime.now();
  String id;
  bool isDone;

  Todo({
    @required this.task,
    @required this.now,
    this.id,
    this.isDone = false,
  });
  static Todo fromJson(Map<String, dynamic> json) => Todo(
        now: Utils.toDateTime(json['createdTime']),
        task: json['task'],
        id: json['id'],
        isDone: json['isDone'],
      );

  Map<String, dynamic> toJson() => {
        'createdTime': Utils.fromDateTimeToJson(now),
        'task': task,
        'id': id,
        'isDone': isDone,
      };
}
