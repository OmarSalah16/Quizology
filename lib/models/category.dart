import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Category {
  final int id;
  final String name;
  final IconData icon;

  Category(this.id, this.name, this.icon);

  List<Category> newlist(List<Category> cat, List<int> favcat) {
    List<Category> new_list = [];
    for (var i = 0; i < favcat.length; i++) {
      if (favcat.contains(i)) {
        new_list.add(cat[i]);
      }
    }
    return new_list;
  }
}

List<Category> categories = [
  Category(9, "General Knowledge", FontAwesomeIcons.globeAfrica),
  Category(10, "Books", FontAwesomeIcons.bookOpen),
  Category(11, "Film", FontAwesomeIcons.video),
  Category(12, "Music", FontAwesomeIcons.music),
  Category(13, "Musicals & Theatres", FontAwesomeIcons.theaterMasks),
  Category(14, "Television", FontAwesomeIcons.tv),
  Category(15, "Video Games", FontAwesomeIcons.gamepad),
  Category(16, "Board Games", FontAwesomeIcons.chessBoard),
  Category(17, "Science & Nature", FontAwesomeIcons.microscope),
  Category(18, "Computer", FontAwesomeIcons.laptopCode),
  Category(19, "Maths", FontAwesomeIcons.sortNumericDown),
  Category(20, "Mythology", FontAwesomeIcons.book),
  Category(21, "Sports", FontAwesomeIcons.footballBall),
  Category(22, "Geography", FontAwesomeIcons.mountain),
  Category(23, "History", FontAwesomeIcons.monument),
  Category(24, "Politics", FontAwesomeIcons.angellist),
  Category(25, "Art", FontAwesomeIcons.paintBrush),
  Category(26, "Celebrities", FontAwesomeIcons.star),
  Category(27, "Animals", FontAwesomeIcons.dog),
  Category(28, "Vehicles", FontAwesomeIcons.carAlt),
  Category(29, "Comics", Icons.library_books),
  Category(30, "Gadgets", FontAwesomeIcons.mobileAlt),
  Category(31, "Japanese Anime & Manga", FontAwesomeIcons.odnoklassniki),
  Category(32, "Cartoon & Animation", FontAwesomeIcons.smileWink),
];
