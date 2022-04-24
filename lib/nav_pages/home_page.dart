import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/models/task.dart';

import '../db/boxes.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ValueListenableBuilder<Box<Task>>(
            valueListenable: Boxes.getTasks().listenable(),
            builder: (context, box, _) {
              final tasks = box.values.toList().cast<Task>();

              if (tasks.isNotEmpty) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, right: 10, left: 10, bottom: 5),
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                        itemCount: 1,
                        itemBuilder: (context, index) {
                          return Column(
                            children: <Widget>[
                              SizedBox(height: 5),
                              Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Text(
                                    "Today",
                                    style: TextStyle(
                                        fontFamily: 'Rubik',
                                        color: Colors.blue),
                                  )),
                              SizedBox(height: 10),
                              ListView.builder(
                                  physics: ClampingScrollPhysics(),
                                  itemCount: tasks.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index2) {
                                    return CardItem(tasks[index2]);
                                  }),
                            ],
                          );
                        }),
                  ),
                );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset("assets/ic_no_tasks.svg"),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "No Tasks",
                        style: TextStyle(
                            fontFamily: 'Rubik', color: Color(0xFF554E8F)),
                      )
                    ],
                  ),
                );
              }
            }));
  }
}

class CardItem extends StatefulWidget {
  Task task;

  CardItem(this.task);

  @override
  State<CardItem> createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  @override
  Widget build(BuildContext context) {
    bool _isChecked = true;

    return SizedBox(
        height: 55,
        child: Card(
          color: Color(int.parse(defineColor(widget.task.taskType))),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 6,
          shadowColor: Color(0xFFEBEDF0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            padding: EdgeInsets.only(top: 12, bottom: 12, right: 12),
            margin: EdgeInsets.only(left: 7),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Transform.scale(
                  scale: 0.9,
                  child: Checkbox(
                    value: _isChecked,
                    side: MaterialStateBorderSide.resolveWith(
                      (states) => BorderSide(
                          width: 1,
                          color: _isChecked
                              ? Color(0xFF91DC5A)
                              : Color(0xFFB5B5B5)),
                    ),
                    checkColor: Colors.white,
                    activeColor: Color(0xFF91DC5A),
                    shape: CircleBorder(),
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                ),
                SizedBox(width: 6),
                Text(widget.task.date,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Rubik',
                      color: Color(0xFFC6C6C8)),
                ),
                SizedBox(width: 10),
                Expanded(
                    child: Text(
                  widget.task.name,
                  style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Rubik',
                      color: Color(0xFF554E8F)),
                )),
                SizedBox(width: 10),
                Icon(
                  Icons.notifications,
                  color: Color(0xFFD9D9D9),
                )
              ],
            ),
          ),
        ));
  }
}

String defineColor(int type) {
  late String color;
  switch (type) {
    case 0:
      color = "0xFFFFD506";
      break;
    case 1:
      color = "0xFF5DE61A";
      break;
    case 2:
      color = "0xFFD10263";
      break;
    case 3:
      color = "0xFFF29130";
      break;
    case 4:
      color = "0xFF09ACCE";
      break;
    case 5:
      color = "0xFF3044F2";
      break;
  }
  return color;
}
