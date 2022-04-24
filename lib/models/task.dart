import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String name;
  @HiveField(1)
  int taskType;
  @HiveField(2)
  String date;
  @HiveField(3)
  String time;

  @override
  String toString() {
    return 'Task{name: $name, taskType: $taskType, date: $date, time: $time}';
  }

  Task(this.name, this.taskType, this.date, this.time);
}
