import 'dart:convert';

import 'package:http/http.dart';
import 'package:opentrivia_quiz_game_final/models/category.dart';
import 'package:opentrivia_quiz_game_final/models/question.dart';

const baseURl = 'https://opentdb.com/api.php';

Future<List<Question>> getQuestions(Category category, int noOfQuestion, String diffculty) async
{
  String url = '$baseURl?amount=$noOfQuestion&category=${category.id}&diffculty=${diffculty.toLowerCase()}';
  print('This is final URL: $url');

  Response response = await get(Uri.parse(url));

  List<Map<String, dynamic>> questions = List<Map<String, dynamic>>.from(jsonDecode(response.body)['results']);

  return Question.fromData(questions);
}
