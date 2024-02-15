import 'dart:js';

import 'package:flutter/material.dart';
import 'package:kai_app/main.dart';
import 'package:kai_app/home.dart';

class Splash extends StatefulWidget {
  const Splash({key? key}) : super(key: key);

  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(milliseconds: 1500), () {});
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage(
                  title: 'GFG',
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Text(
          'Splash Screen',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
