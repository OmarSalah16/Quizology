import 'package:flutter/material.dart';
import 'package:opentrivia_quiz_game_final/models/question.dart';
import 'package:opentrivia_quiz_game_final/screens/home.dart';

import 'answer_screen.dart';

class Result extends StatelessWidget {
  final List<Question> question;
  final Map<int, dynamic> answer;
  Result({required this.question, required this.answer});
  @override
  Widget build(BuildContext context) {
    int correct = 0;

    this.answer.forEach((index, value) {
      if (question[index].correct_answer == value) {
        correct++;
      }
    });

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Result'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Color(0xff253445),
                ),
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      height: 10.0,
                    ),
                    ReUsableListTile(
                      leading: 'Score',
                      trailing:
                          '${(correct / question.length * 100).toStringAsFixed(1)}% / 100%',
                    ),
                    ReUsableListTile(
                      leading: 'Correct Answer',
                      trailing: '$correct / ${question.length}',
                    ),
                    ReUsableListTile(
                      leading: 'Incorrect Answer',
                      trailing:
                          '${question.length - correct} / ${question.length}',
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[700],
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Home()));
                  },
                  child: Text(
                    'Home',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                width: double.infinity,
                height: 50.0,
              ),
              SizedBox(
                height: 10.0,
              ),
              Container(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Answer(
                          answer: answer,
                          question: question,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    'Show Answers',
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ),
                width: double.infinity,
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReUsableListTile extends StatelessWidget {
  final String leading;
  final String trailing;
  ReUsableListTile({required this.leading, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        leading: Text(
          leading,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
        trailing: Text(
          trailing,
          style: TextStyle(
            fontSize: 18.0,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

// String getEmoji(int val) {
//   String path = 'assets/svg/';
//   if (val >= 80) {
//     return '${path + 'lovely.svg'}';
//   } else if (val >= 60) {
//     return '${path + 'not_bad.svg'}';
//   } else if (val >= 40) {
//     return '${path + 'tooth_crunch.svg'}';
//   } else if (val >= 20) {
//     return '${path + 'cry.svg'}';
//   } else {
//     return '${path + 'total_fail.svg'}';
//   }
// }
