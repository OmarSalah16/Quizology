// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:opentrivia_quiz_game_final/models/question.dart';

import 'home.dart';

class Answer extends StatelessWidget {
  final Map<int, dynamic> answer;
  final List<Question> question;
  Answer({required this.question, required this.answer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Answers'),
        ),
        body: Column(
          children: [
            Expanded(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: question.length,
              itemBuilder: (context, index) {
                bool correct = question[index].correct_answer == answer[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 4.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3.0),
                    ),
                    padding: EdgeInsets.all(8.0),
                    child: ListBody(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(
                            HtmlUnescape().convert(question[index].question),
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Color(0xff6C7C8D),
                            ),
                          ),
                        ),
                        Text(
                          HtmlUnescape().convert('${answer[index]}'),
                          style: TextStyle(
                            color: correct ? Colors.green : Colors.red,
                            fontSize: 17.0,
                          ),
                        ),
                        correct ? Container()
                            : Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Answer : ',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Color(0xff6C7C8D),
                                      ),
                                    ),
                                    TextSpan(
                                      text: HtmlUnescape().convert(
                                          '${question[index].correct_answer}'),
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: Color(0xff6C7C8D),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                );
              },
            )),
            SizedBox(height: 10),
            MaterialButton(
              padding: EdgeInsets.all(15),
              color: Colors.green[700],
              minWidth: MediaQuery.of(context).size.width / 1.5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              elevation: 3,
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home()));
              },
              child: Text(
                'Home',
                style: TextStyle(fontSize: 20.0, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
