import 'package:cinema/screens/CardScreen.dart';
import 'package:cinema/screens/HomeScreen.dart';
import 'package:cinema/screens/SettingScreen.dart';
import 'package:cinema/screens/supporting/Navigation.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Navigation(),
    );
  }
}