// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:opentrivia_quiz_game_final/screens/sign_in.dart';

class Intro extends StatelessWidget
{
  const Intro({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp
    (
      debugShowCheckedModeBanner: false,
      title: 'Welcome to Quizology',
      home: Scaffold
      (
        backgroundColor: Color(0xff393d4e),
        body: Center
        (
          child: Container
          (
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Column
            (
              crossAxisAlignment: CrossAxisAlignment.center,
              children:
              [
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Image.asset('assets/otdb.png', height: 200),
                Text
                (
                  "OpenTrivia is an online database that stores questions of different categories & difficulties.",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                Text
                (
                  "There are over 20 Categories of different questions in OpenTrivia DB.",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                Text
                (
                  "OpenTrivia allows you to choose the level of difficulty of the questions from (Easy, Medium, Hard).",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                  textAlign: TextAlign.center
                ),

                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                MaterialButton
                (
                  color: Color(0xffff7730),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  padding: EdgeInsets.all(20),
                  minWidth: MediaQuery.of(context).size.width / 1.5,
                  onPressed: () {Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => Login()));},
                  child: Text("Proceed to Login", style: TextStyle(fontSize: 20, color: Colors.white))
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}
