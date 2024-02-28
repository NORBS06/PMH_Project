import 'package:flutter/material.dart';
import 'package:kai_app/pallete.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('KAI'),
        leading: const Icon(Icons.menu),
      ),
      floatingActionButton: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
          ),
          FloatingActionButton.extended(
            backgroundColor: Colors.transparent,
            onPressed: () {},
            label: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                'assets/images/virtualAssistant.png',
                width: 250,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            foregroundColor: Colors.white,
            shape: const CircleBorder(
              side: BorderSide(
                width: 250,
                style: BorderStyle.none,
              ),
            ),
            elevation: 0,
            highlightElevation: 0,
            hoverElevation: 0,
          ),
          //chat bubble
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal:20,
              vertical:10,
            ),
            margin: const EdgeInsets.symmetric(horizontal: 40).copyWith(
              top:30,
            ),
            decoration: BoxDecoration(border: Border.all(
              color: Pallete.borderColor
            ),
            borderRadius: BorderRadius.circular(20).copyWith(
              topLeft: Radius.zero,
            ),
            ),
            child: const Text('Hello, what can do for you?',style:  TextStyle(
              fontFamily: 'Cera Pro',
              color: Pallete.mainFontColor,
              fontSize: 25,
            ),),
          )
        ],
      ),
    );
  }
}
