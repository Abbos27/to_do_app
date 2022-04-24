import 'package:hive/hive.dart';
import 'package:to_do_app/models/task.dart';

class Boxes{
  static Box<Task> getTasks()=>Hive.box('tasks');
}