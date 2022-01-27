import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import '../screens/bottom_navigation_screen.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BottomNavigationScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 250.0,
          child: TypewriterAnimatedTextKit(
            onTap: () {
              print("Tap Event");
            },
            text: [
              "Discipline is the best tool",
              "Design first, then code",
              "Do not patch bugs out, rewrite them",
              "Do not test bugs out, design them out",
            ],
            textStyle: TextStyle(fontSize: 30.0, fontFamily: "Agne"),
            textAlign: TextAlign.start,
          ),
        ),
      ),
    );
  }
}
