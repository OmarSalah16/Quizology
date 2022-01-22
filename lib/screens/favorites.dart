import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:opentrivia_quiz_game_final/models/category.dart';
import 'package:opentrivia_quiz_game_final/providers/user_provider.dart';
import 'package:opentrivia_quiz_game_final/screens/favorites.dart';
import 'package:opentrivia_quiz_game_final/screens/home.dart';
import 'package:opentrivia_quiz_game_final/screens/sign_in.dart';
import 'package:opentrivia_quiz_game_final/widgets/options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class favorites extends StatefulWidget {
  @override
  _favorites createState() => _favorites();
}

class _favorites extends State<favorites> {
  Widget _buildList(int index) {
    Category category = categories[index];
    var cat = Category;

    return MaterialButton(
        onPressed: () async {
          showDialog(
              barrierColor: Theme.of(context).primaryColor,
              context: context,
              builder: (context) => AlertDialog(
                    title: Text(category.name, textAlign: TextAlign.center),
                    content:
                        Options(category: category), // Toggles Options Menu
                  ));
        },
        color: Colors.white,
        padding: EdgeInsets.all(10.0),
        child: ListTile(
            title:
                Text(category.name, style: TextStyle(color: Color(0xff6C7C8D))),
            leading: Icon(category.icon, color: Color(0xff6C7C8D))));
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Theme.of(context).primaryColor,
        ),
        child: Scaffold(
          drawer: Drawer(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Color(0xff393d4e)),
                child: Text('Welcome, Guest.',
                    style: TextStyle(fontSize: 20, color: Colors.white)),
              ),
              ListTile(
                title: const Text('Sign Out',
                    style: TextStyle(fontSize: 20, color: Color(0xff393d4e))),
                onTap: () {
                  signOut();
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Login()));
                },
              ),
              ListTile(
                title: const Text('Favourites',
                    style: TextStyle(fontSize: 20, color: Color(0xff393d4e))),
                onTap: () {
                  // Navigator.pushReplacement(
                  // context, MaterialPageRoute(builder: (_) => favorites()));
                },
              ),
              ListTile(
                title: const Text('home',
                    style: TextStyle(fontSize: 20, color: Color(0xff393d4e))),
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => Home()));
                },
              ),
            ],
          )),
          backgroundColor: Theme.of(context).primaryColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: Theme.of(context).primaryColor),
            title: Text('Quizology'),
          ),
          body: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) => _buildList(index)),
        ));
  }
}

void signOut() async {
  final _auth = FirebaseAuth.instance;
  //await _auth.signOut();
  try {
    await _auth.signOut();
    Fluttertoast.showToast(msg: "Sign out Successful");
  } catch (error) {
    Fluttertoast.showToast(msg: "Sign out Unsuccessful");
  }
}