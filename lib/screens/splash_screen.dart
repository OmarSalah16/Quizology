
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:opentrivia_quiz_game_final/screens/intro.dart';

class SplashScreen extends StatefulWidget
{
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
{
  @override
  void initState()
  {
    super.initState();
    Timer(const Duration(seconds: 3), ()
    {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Intro()));
    });
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold
    (
      backgroundColor: const Color(0xff393d4e),
      body: Center
      (
        child: Column
        (
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: 
          [
            Image.asset('assets/splash.png', height: 150),
            Text("Quizology", style: TextStyle(color: Color(0xffff7126), fontSize: 20, fontWeight: FontWeight.w700))
          ]
        )
      )
    );
  }
}
