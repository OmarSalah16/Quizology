import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:opentrivia_quiz_game_final/api_provider/question_api.dart';
import 'package:opentrivia_quiz_game_final/models/category.dart';
import 'package:opentrivia_quiz_game_final/models/question.dart';
import 'package:opentrivia_quiz_game_final/models/user.dart';
import 'package:opentrivia_quiz_game_final/providers/user_provider.dart';
import 'package:opentrivia_quiz_game_final/screens/favorites.dart';
import 'package:opentrivia_quiz_game_final/screens/home.dart';
import 'package:opentrivia_quiz_game_final/screens/quiz_screen.dart';
import 'package:opentrivia_quiz_game_final/services/fire_store_services.dart';
import 'package:provider/provider.dart';

import 'custom_action_chip.dart';

class Options extends StatefulWidget {
  final Category category;

  Options({required this.category});
  @override
  _OptionsState createState() => _OptionsState();
}

class _OptionsState extends State<Options> {
  late int _noOfQuestion;
  late String _difficulty;
  late bool processing;
  FireStoreServices fs = FireStoreServices();
  @override
  void initState() {
    _noOfQuestion = 10;
    _difficulty = 'Easy';
    processing = false;
    super.initState();
  }

  _selectedQuestion(int question) async {
    setState(() {
      _noOfQuestion = question;
    });
  }

  _selectedDifficulty(String difficulty) async {
    setState(() {
      _difficulty = difficulty;
    });
  }

  _startQuiz() async {
    setState(() {
      processing = true;
    });

    try {
      List<Question> question =
          await getQuestions(widget.category, _noOfQuestion, _difficulty);
      if (question.length < 1) {
        Fluttertoast.showToast(
          backgroundColor: Theme.of(context).primaryColor,
          msg: 'No Questions Available',
          gravity: ToastGravity.BOTTOM,
        );
        Navigator.pop(context);
      } else {
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Quiz(
              category: widget.category,
              question: question,
            ),
          ),
        );
      }
    } on SocketException catch (_) {
      Fluttertoast.showToast(
        backgroundColor: Theme.of(context).primaryColor,
        msg: 'Can\'t reach Server',
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
    } catch (err) {
      Fluttertoast.showToast(
        backgroundColor: Theme.of(context).primaryColor,
        msg: 'Unexpected Err',
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Add to Favorites?'),
              if (!Provider.of<UserProvider>(context, listen: false)
                  .getUser
                  .favorites
                  .contains(Provider.of<UserProvider>(context, listen: false)
                      .getUser
                      .currentcategory)) ...[
                IconButton(
                    icon: Icon(Icons.star),
                    iconSize: 24.0,
                    color: Colors.black,
                    onPressed: () {
                      setState(() {
                        Provider.of<UserProvider>(context, listen: false)
                            .getUser
                            .favorites
                            .add(Provider.of<UserProvider>(context,
                                    listen: false)
                                .getUser
                                .currentcategory);
                        fs.updatefavorites(
                            Provider.of<UserProvider>(context, listen: false)
                                .getUser
                                .favorites);
                      });
                    }),
              ] else ...[
                IconButton(
                  icon: Icon(Icons.star),
                  iconSize: 24.0,
                  color: Colors.red,
                  onPressed: () {
                    setState(() {
                      if (Provider.of<UserProvider>(context, listen: false)
                          .getUser
                          .favorites
                          .contains(
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .currentcategory)) {
                        Provider.of<UserProvider>(context, listen: false)
                            .getUser
                            .favorites
                            .remove(Provider.of<UserProvider>(context,
                                    listen: false)
                                .getUser
                                .currentcategory);
                        fs.updatefavorites(
                            Provider.of<UserProvider>(context, listen: false)
                                .getUser
                                .favorites);
                      }
                    });
                  },
                )
              ]
            ],
          ),
          ElevatedButton(
              child: Text("Go to Favorites"),
              style: ElevatedButton.styleFrom(primary: Colors.blueGrey),
              onPressed: () {
                setState(() {
                  Provider.of<UserProvider>(context, listen: false)
                      .getUser
                      .favorites;
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => favorites()));
                });
              }),
          SizedBox(height: 20.0),
          Text('Select Total No of Question'),
          Wrap(alignment: WrapAlignment.center, spacing: 10.0, children: [
            CustomActionChip(
              name: '10',
              backGroundColor: _noOfQuestion == 10
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
              onPressed: () => _selectedQuestion(10),
            ),
            CustomActionChip(
              name: '20',
              onPressed: () => _selectedQuestion(20),
              backGroundColor: _noOfQuestion == 20
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
            CustomActionChip(
              name: '30',
              onPressed: () => _selectedQuestion(30),
              backGroundColor: _noOfQuestion == 30
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
            CustomActionChip(
              name: '40',
              onPressed: () => _selectedQuestion(40),
              backGroundColor: _noOfQuestion == 40
                  ? Theme.of(context).primaryColor
                  : Colors.grey,
            ),
          ]),
          SizedBox(height: 15.0),
          Text('Select Difficulty'),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10.0,
            children: [
              CustomActionChip(
                name: 'Easy',
                onPressed: () => _selectedDifficulty('Easy'),
                backGroundColor: _difficulty == 'Easy'
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              CustomActionChip(
                name: 'Medium',
                onPressed: () => _selectedDifficulty('Medium'),
                backGroundColor: _difficulty == 'Medium'
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
              CustomActionChip(
                name: 'Hard',
                onPressed: () => _selectedDifficulty('Hard'),
                backGroundColor: _difficulty == 'Hard'
                    ? Theme.of(context).primaryColor
                    : Colors.grey,
              ),
            ],
          ),
          SizedBox(height: 15.0),
          processing
              ? CircularProgressIndicator(color: Theme.of(context).primaryColor)
              : Container(
                  width: double.infinity,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      side: BorderSide(
                          width: 1.0, color: Theme.of(context).primaryColor),
                    ),
                    child: Text(
                      'Start Quiz',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                    onPressed: () {
                      _startQuiz();
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
