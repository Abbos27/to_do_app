import 'package:to_do_app/models/task.dart';

class TimeItem{
  String date;
  List<Task> tasks;

  TimeItem(this.date, this.tasks);

  @override
  String toString() {
    return date;
  }
}