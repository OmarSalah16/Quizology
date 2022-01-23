import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:opentrivia_quiz_game_final/models/category.dart';
import 'package:opentrivia_quiz_game_final/providers/user_provider.dart';
import 'package:opentrivia_quiz_game_final/screens/favorites.dart';
import 'package:opentrivia_quiz_game_final/screens/sign_in.dart';
import 'package:opentrivia_quiz_game_final/services/storage_service.dart';
import 'package:opentrivia_quiz_game_final/widgets/options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home>
{
  File? imageFile;
  Future pickImage() async
  {
    final picker = ImagePicker();
    // ignore: deprecated_member_use
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(()
    {
      try
      {
        imageFile = File(pickedFile!.path);
        print("Image uploaded");
      } catch (e){
        print(e);
      }
    });
  }

  Widget _buildList(int index)
  {
    Category category = categories[index];

    return MaterialButton
    (
      onPressed: () async
      {
        Provider.of<UserProvider>(context, listen: false).getUser.currentcategory = index;
        //print(index);
        showDialog
        (
          barrierColor: Theme.of(context).primaryColor,
          context: context,
          builder: (context) => AlertDialog
          (
            title: Text(category.name, textAlign: TextAlign.center),
            content: Options(category: category), // Toggles Options Menu
          )
        );
      },
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: ListTile
      (
        title: Text(category.name, style: TextStyle(color: Color(0xff6C7C8D))),
        leading: Icon(category.icon, color: Color(0xff6C7C8D))
      ),
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return AnnotatedRegion<SystemUiOverlayStyle>
    (
        value: SystemUiOverlayStyle
        (
          systemNavigationBarColor: Theme.of(context).primaryColor,
        ),
        child: Scaffold
        (
          drawer: Drawer
          (
            child: ListView
            (
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                  decoration: BoxDecoration(color: Color(0xff393d4e)),
                  child: Column(
                    children: [
                      Text(
                          'Welcome, ' + Provider.of<UserProvider>(context, listen: false).getUser.firstName,
                          style: TextStyle(fontSize: 20, color: Colors.white)),
                      SizedBox(height: 10,),
                      GestureDetector(
                        onTap: () async {
                          try {
                            await pickImage();
                            await StorageRepo().uploadFile(imageFile!);
                            var url = await StorageRepo().getUserProfileImage(
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .getUser
                                    .uid);
                            setState(() {
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .avatarUrl = url;
                            });
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(
                              Provider.of<UserProvider>(context, listen: false)
                                  .getUser
                                  .avatarUrl),
                          radius: MediaQuery.of(context).size.height / 16,
                        ),
                      ),
                    ],
                  )),
              ListTile(
                title: const Text('Favourites',
                    style: TextStyle(fontSize: 20, color: Color(0xff393d4e))),
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => favorites()));
                },
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
