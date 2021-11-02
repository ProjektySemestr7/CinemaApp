import 'package:cinema/screens/CardScreen.dart';
import 'package:cinema/screens/HomeScreen.dart';
import 'package:cinema/screens/SettingScreen.dart';
import 'package:cinema/screens/supporting/Navigation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'login/LogInScreen.dart';
import 'login/LogRegScreen.dart';
import 'login/RegisterScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
      home: const LogRegScreen(),
      routes: {
        Navigation.id: (context) => Navigation(),
        HomeScreen.id: (context) => HomeScreen(),
        CardScreen.id: (context) => CardScreen(),
        SettingsScreen.id: (context) => SettingsScreen(),
        LogRegScreen.id: (context) => LogRegScreen(),
        LogInScreen.id: (context) => LogInScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
      },
    );
  }
}
