import 'package:flutter/material.dart';

class OpenTask extends StatefulWidget {
  const OpenTask({Key? key}) : super(key: key);

  @override
  State<OpenTask> createState() => _OpenTaskState();
}

class _OpenTaskState extends State<OpenTask> {
  String taskType = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Text(taskType),
    );
  }
}
