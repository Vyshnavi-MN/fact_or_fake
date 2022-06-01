import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:fact_or_fake/intro_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "Fact-Fake",
        // theme: ThemeData(
        //   primarySwatch: Colors.blue,
        // ),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          textTheme: const TextTheme(
            headline4: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
            headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          ),
        ),
        home: AnimatedSplashScreen(
          duration: 3000,
          splash: const Image(
            image: AssetImage("assets/images/splashIcon.png"),
          ),
          splashIconSize: 300,
          nextScreen: const IntroScreen(),
          splashTransition: SplashTransition.rotationTransition,
          pageTransitionType: PageTransitionType.leftToRightWithFade,
          backgroundColor: Colors.blue.shade50,
        ));
  }
}
