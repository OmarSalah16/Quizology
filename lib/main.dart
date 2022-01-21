import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:opentrivia_quiz_game_final/screens/home.dart';
import 'package:opentrivia_quiz_game_final/screens/sign_in.dart';
import 'screens/splash_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:opentrivia_quiz_game_final/services/local_notification_service.dart';

Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.initialize;
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizology',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color(0xff393d4e)),
      home: SplashScreen(),
      routes: {
        "login": (_) => SplashScreen(),
        "home": (_) => Home(),
      },
    );
  }
}
