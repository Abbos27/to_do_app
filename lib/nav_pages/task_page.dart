import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:to_do_app/db/boxes.dart';
import 'package:to_do_app/models/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  int counter1 = 0;
  int counter2 = 0;
  int counter3 = 0;
  int counter4 = 0;
  int counter5 = 0;
  int counter6 = 0;
  List<Task> tasks = Boxes.getTasks().values.toList().cast<Task>();

  List<CardModel> cards = [
    CardModel('Personal', 'assets/cardImages/ic_personal.svg', '0xFFFFF9DB', 0),
    CardModel('Work', 'assets/cardImages/ic_work.svg', '0xFFFFF9DB', 0),
    CardModel('Meeting', 'assets/cardImages/ic_meeting.svg', '0xFFFFDBED', 0),
    CardModel('Shopping', 'assets/cardImages/ic_personal.svg', '0xFFFFF9DB', 0),
    CardModel('Party', 'assets/cardImages/ic_party.svg', '0xFFD8FBF9', 0),
    CardModel('Study', 'assets/cardImages/ic_study.svg', '0xFFF7D8FB', 0)
  ];

  @override
  Widget build(BuildContext context) {
    countTasks();
    cards[0].taskNum = counter1;
    cards[1].taskNum = counter2;
    cards[2].taskNum = counter3;
    cards[3].taskNum = counter4;
    cards[4].taskNum = counter5;
    cards[5].taskNum = counter6;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Projects",
              style: TextStyle(fontFamily: 'Rubik', color: Color(0xFF8B87B3))),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: StaggeredGridView.countBuilder(
                  physics: BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics()),
                  itemCount: cards.length,
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  itemBuilder: (context, index) => taskCard(
                        context,
                        cards[index],
                      ),
                  staggeredTileBuilder: (index) => StaggeredTile.count(1, 1.1)))
        ],
      ),
    ));
  }

  Widget taskCard(
    BuildContext context,
    CardModel card,
  ) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.only(top: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
              child: SvgPicture.asset(card.image),
              backgroundColor: Color(int.parse(card.iconBackgroundColor)),
              radius: 35,
            ),
            Text(
              card.type,
              style: TextStyle(
                  fontSize: 20, color: Colors.blueGrey, fontFamily: 'Rubik'),
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  card.taskNum.toString(),
                  style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                ),
                SizedBox(
                  width: 2,
                ),
                Text(
                  "Task",
                  style: TextStyle(fontSize: 10, color: Colors.blueGrey),
                )
              ],
            )
          ],
        ),
      ),
      elevation: 6,
      shadowColor: Color(0xFFEBEDF0),
    );
  }

  void countTasks() {
    for (var element in tasks) {
      switch (element.taskType) {
        case 0:
          counter1++;
          break;
        case 1:
          counter2++;
          break;
        case 2:
          counter3++;
          break;
        case 3:
          counter4++;
          break;
        case 4:
          counter5++;
          break;
        case 5:
          counter6++;
          break;
      }
    }
  }
}

class CardModel {
  String type;
  String image;
  String iconBackgroundColor;
  int taskNum;

  CardModel(this.type, this.image, this.iconBackgroundColor, this.taskNum);
}
