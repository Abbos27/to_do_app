import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/db/boxes.dart';
import 'package:to_do_app/models/task.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final taskController = TextEditingController();
  bool _validate_task = false;
  String dateTime = "";

  @override
  void dispose() {
    Hive.box('tasks').close();
    super.dispose();
  }

  List<RadioBtnModel> customRadios = [
    RadioBtnModel("Personal", '0xFFFFD506'),
    RadioBtnModel("Work", '0xFF5DE61A'),
    RadioBtnModel("Meeting", '0xFFD10263'),
    RadioBtnModel("Shopping", '0xFFF29130'),
    RadioBtnModel("Party", '0xFF09ACCE'),
    RadioBtnModel("Study", '0xFF3044F2'),
  ];
  int selectedRadio = 0;
  bool chooseDate = false;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
        initialChildSize: 0.75,
        builder: (_, controller) => Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.elliptical(250, 30))),
              child: Padding(
                padding: const EdgeInsets.only(top: 12, right: 18, left: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Text("Add new tasks",
                        style: TextStyle(
                            fontFamily: 'Rubik', color: Colors.black)),
                    TextFormField(
                        maxLines: 1,
                        controller: taskController,
                        decoration: InputDecoration(
                          hintText: "Enter task",
                          errorText: _validate_task ? 'Enter task name' : null,
                        )),
                    SizedBox(
                      height: 5,
                    ),
                    SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: List.generate(customRadios.length, (index) {
                          return customRadio(customRadios[index], index);
                        }),
                      ),
                    ),
                    Divider(
                      color: Colors.grey,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: TextButton.icon(
                          icon: chooseDate
                              ? Icon(
                                  Icons.expand_less,
                                  color: Colors.black,
                                )
                              : Icon(
                                  Icons.expand_more,
                                  color: Colors.black,
                                ),
                          label: Text(
                            "Choose date",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            setState(() {
                              chooseDate = !chooseDate;
                            });
                          },
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(dateTime.toString())),
                    Visibility(
                      visible: chooseDate,
                      child: Container(
                        child: showDate(),
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 35, vertical: 14),
                                child: ElevatedButton(
                                    onPressed: () {
                                      taskController.text.isEmpty
                                          ? _validate_task = true
                                          : _validate_task = false;

                                      if (taskController.text.isNotEmpty && dateTime.isNotEmpty) {
                                        Task task = Task(
                                            taskController.text.toString(),
                                            selectedRadio,
                                            dateTime,
                                            "time");
                                        Navigator.pop(context, task);
                                      }
                                    },
                                    style: ButtonStyle(
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xFF76A9F9)),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Color(0xFF76A9F9)),
                                        shadowColor: MaterialStateProperty.all(
                                            Color(0xFF76A9F9)),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Text(
                                        "Add task",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.white,
                                          fontFamily: 'Rubik',
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  Widget customRadio(RadioBtnModel btn, int index) {
    return OutlinedButton(
      onPressed: () {
        setState(() {
          selectedRadio = index;
        });
      },
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 8,
            width: 8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Color(int.parse(btn.color))),
          ),
          SizedBox(width: 4),
          Text(
            btn.type,
            style: TextStyle(
                fontSize: 12,
                color: (selectedRadio == index) ? Colors.white : Colors.grey),
          )
        ],
      ),
      style: OutlinedButton.styleFrom(
          side: BorderSide(
              color: (selectedRadio == index)
                  ? Color(int.parse(btn.color))
                  : Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          backgroundColor: (selectedRadio == index)
              ? Color(int.parse(btn.color))
              : Colors.white),
    );
  }

  Future addTask(String name, int taskType, String date, String time) async {
    final task = Task(name, taskType, date, time);
    final box = Boxes.getTasks();
    box.add(task);
  }

  Widget showDate() => SizedBox(
        height: 180,
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (dateTime) => setState(() {
            if(dateTime.hour>=0 && dateTime.hour<=12){
              this.dateTime = "${dateTime.hour}:${dateTime.minute} AM";
            }else{
              this.dateTime = "${dateTime.hour}:${dateTime.minute} PM";
            }
          }),
          mode: CupertinoDatePickerMode.time,
        ),
      );

}

class RadioBtnModel {
  String type;
  String color;

  RadioBtnModel(this.type, this.color);
}
