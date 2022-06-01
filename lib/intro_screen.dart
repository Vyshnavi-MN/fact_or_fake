import 'package:fact_or_fake/home.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  IntroScreenState createState() => IntroScreenState();
}

class IntroScreenState extends State<IntroScreen> {
  static const _titles = <String>[
    "Long passages are \nprosaic",
    "Allows the reader \nto contextualize \nwhat you are saying",
    "Paste an article, \nparagraph, essay and \nclick summarize",
    "Focus on what is \nimportant for you",
    "Facts or Fake news\nLet's find out!"
  ];

  late Timer _timer;
  int index = 0;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (index < _titles.length - 1) {
        setState(() {
          index++;
        });
      }

      if (index == _titles.length - 1) {
        _timer.cancel();
        Future.delayed(const Duration(seconds: 4), () {
          pushReplacementHomePage();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.blue.shade50,
      child: Stack(
        children: [
          Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: Text(
                _titles[index],
                key: ValueKey(_titles[index]),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
          ),
          Positioned(
            bottom: 34,
            right: 34,
            child: FlatButton(
              onPressed: () {
                _timer.cancel();
                pushReplacementHomePage();
              },
              child: Text(
                "Skip",
                style: Theme.of(context).textTheme.headline6,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void pushReplacementHomePage() {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const MyHomePage()));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
