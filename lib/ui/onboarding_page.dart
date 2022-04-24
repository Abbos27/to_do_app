import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:to_do_app/routes/app_routes.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 2,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset("assets/my_intro.svg"))),
            Expanded(
              flex: 1,
              child: Center(
                child: Text(
                  "Reminders made simple",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'Rubik',
                    color: Color(0xFF554E8F),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 75),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.navPage);
                          },
                          style: ButtonStyle(
                              foregroundColor:
                                  MaterialStateProperty.all(Color(0xFFFCFCFC)),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFF4BC60D)),
                              shadowColor:
                                  MaterialStateProperty.all(Color(0xFF4BC60D)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ))),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              "Get Started",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Rubik',
                              ),
                            ),
                          )),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
