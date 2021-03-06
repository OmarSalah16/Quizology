import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:opentrivia_quiz_game_final/models/category.dart';
import 'package:opentrivia_quiz_game_final/models/question.dart';
import 'package:opentrivia_quiz_game_final/screens/result_screen.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';

class Quiz extends StatefulWidget
{
  final List<Question> question;
  final Category category;
  Quiz({required this.category, required this.question});

  @override
  _QuizState createState() => _QuizState();
}

class _QuizState extends State<Quiz>
{
  int _currentIndex = 0;
  final Map<int, dynamic> _answers = {};
  final FlutterTts flutterTts = FlutterTts();

  @override
  Widget build(BuildContext context)
  {
    Future speak(String text) async
    {
      await flutterTts.setLanguage("en-US");
      await flutterTts.setVolume(1);
      await flutterTts.setPitch(1);
      await flutterTts.speak(text);
    }

    Question question = widget.question[_currentIndex];

    final List<dynamic> options = question.incorrect_answer;

    if (!options.contains(question.correct_answer))
    {
      options.add(question.correct_answer);
      options.shuffle();
    }

    return WillPopScope
    (
      onWillPop: _onWillPop,
      child: Scaffold
      (
        backgroundColor: Theme.of(context).primaryColor,
        appBar: AppBar(
          // automaticallyImplyLeading: true,
          backgroundColor: Theme.of(context).primaryColor,
          title: Text(widget.category.name),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: new BorderRadius.circular(16.0),
                          color: Colors.white),
                      child: Row(
                        children: [
                          CountdownTimer(
                            textStyle: TextStyle(fontSize: 25),
                            onEnd: onEnd,
                            endTime: DateTime.now().millisecondsSinceEpoch + 1000 * 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        '${_currentIndex + 1}',
                        style:
                            TextStyle(fontSize: 20.0, color: Color(0xff6C7C8D)),
                      ),
                      alignment: Alignment.center,
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3.0),
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 20.0),
                    Expanded(
                      child: Text(
                        HtmlUnescape().convert(widget.question[_currentIndex].question),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Card(
                  margin: EdgeInsets.zero,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ...options.map((e) => RadioListTile(
                            activeColor: Color(0xff6C7C8D),
                            title: Text(
                              HtmlUnescape().convert(e),
                              style: TextStyle(color: Color(0xff6C7C8D)),
                            ),
                            groupValue: _answers[_currentIndex],
                            value: e.toString(),
                            onChanged: (value) {
                              setState(() {
                                _answers[_currentIndex] = value;
                              });
                            },
                          )),
                    ],
                  ),
                ),
                SizedBox(height: 25.0),
                Container(
                  child: ElevatedButton.icon(
                    onPressed: () => speak(HtmlUnescape().convert(widget.question[_currentIndex].question)),
                    style: ElevatedButton.styleFrom(primary: Colors.blue[700]),
                    icon: Icon(Icons.volume_up),
                    label: Text("Listen to Question"),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Container(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    onPressed: () async {
                      _submit();
                    },
                    child: Text(
                      _currentIndex == (widget.question.length - 1)
                          ? 'Submit'
                          : 'Next',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  width: double.infinity,
                  height: 50.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onEnd() {
    if (_currentIndex < (widget.question.length - 1)) // If this isn't the last question
    {
      if (_answers[_currentIndex] == null) // If the answer is empty
      {
        Fluttertoast.showToast(
          backgroundColor: Theme.of(context).primaryColor,
          msg: 'You failed to answer this question in time.',
          gravity: ToastGravity.BOTTOM,
        );
        _answers[_currentIndex] = "No Answer";
      }

      setState(() {
        _currentIndex++;
      });
    } else //If this IS the last question
    {
      if (_answers[_currentIndex] == null) {
        Fluttertoast.showToast(
          backgroundColor: Theme.of(context).primaryColor,
          msg: 'You failed to answer this question in time.',
          gravity: ToastGravity.BOTTOM,
        );
        _answers[_currentIndex] = "No Answer";
      }

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Result(
                    answer: _answers,
                    question: widget.question,
                  )));
    }
  }

  void _submit() {
    if (_answers[_currentIndex] == null) {
      Fluttertoast.showToast(
        backgroundColor: Theme.of(context).primaryColor,
        msg: 'Please select an answer',
        gravity: ToastGravity.BOTTOM,
      );
    } else if (_currentIndex < (widget.question.length - 1)) {
      setState(() {
        _currentIndex++;
      });
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Result(
                    answer: _answers,
                    question: widget.question,
                  )));
    }
  }

  Future<bool> _onWillPop() async
  {
    return showDialog<bool>
    (
      context: context,
      builder: (context)
      {
        return AlertDialog
        (
          content: Text( 'All your current progress will be lost'),
          actions:
          [
            TextButton
            (
              child: Text
              (
                'Ok',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: ()
              {
                Navigator.of(context).pop(true);
              },
              style:TextButton.styleFrom(primary: Theme.of(context).primaryColor),
            ),
            TextButton
            (
              style:TextButton.styleFrom(primary: Theme.of(context).primaryColor),
              child: Text
              (
                'Cancel',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: ()
              {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    ).then((value) => value ?? false);
  }
}
