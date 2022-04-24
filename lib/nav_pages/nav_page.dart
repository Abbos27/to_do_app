import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/nav_pages/home_page.dart';
import 'package:to_do_app/nav_pages/task_page.dart';
import '../db/boxes.dart';
import '../models/task.dart';
import '../ui/add_page.dart';

class NavPage extends StatefulWidget {
  const NavPage({Key? key}) : super(key: key);

  @override
  State<NavPage> createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  bool isNotificationVisible = true;
  final screens = [HomePage(), TaskPage()];
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: screens[currentIndex],
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // top
            Container(
              color: Color(0xFF5E99E6),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello Brenda!",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Rubik',
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              "Today you have 9 tasks",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Rubik',
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        CircleAvatar(
                          radius: 20,
                          child: ClipOval(
                            child: Container(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isNotificationVisible,
                    child: Container(
                      margin: EdgeInsets.only(
                          left: 22, right: 22, top: 4, bottom: 18),
                      decoration: BoxDecoration(
                        color: Color(0xFF99C4F1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 14, 8, 8),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Today Reminder",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontFamily: 'Rubik',
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 12),
                                  Text(
                                    "Meeting with client",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Rubik',
                                        color: Color(0xFFF3F3F3)),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    "13.00 PM",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'Rubik',
                                        color: Color(0xFFF3F3F3)),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 6),
                            Container(
                              margin: EdgeInsets.only(top: 12),
                              child: SvgPicture.asset(
                                "assets/ic_bell.svg",
                                height: 90,
                                width: 90,
                              ),
                            ),
                            Container(
                              child: Align(
                                alignment: Alignment.topRight,
                                child: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      isNotificationVisible = false;
                                    });
                                  },
                                  constraints: BoxConstraints(),
                                  padding: EdgeInsets.zero,
                                  icon: Icon(Icons.close),
                                  color: Colors.white,
                                  iconSize: 24,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // bottom
            Expanded(
              child: Container(
                child: screens[currentIndex],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.grid_view),
              label: "Tasks",
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFE521A4),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => AddPage(),
          ).then((value) {
            setState(() {
              if (value != null) {
                addTask(value);
              }
            });
          });
        },
        child: SvgPicture.asset('assets/ic_add.svg'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Future addTask(Task task) async {
  final box = Boxes.getTasks();
  box.add(task);
}
