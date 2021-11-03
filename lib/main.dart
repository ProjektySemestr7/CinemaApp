import 'package:cinema/login/LogRegScreen.dart';
import 'package:cinema/login/LoginScreen.dart';
import 'package:cinema/login/RegisterScreen.dart';
import 'package:cinema/screens/CardScreen.dart';
import 'package:cinema/screens/HomeScreen.dart';
import 'package:cinema/screens/SettingScreen.dart';
import 'package:cinema/screens/supporting/Navigation.dart';
import 'package:cinema/storages/UserData.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

UserData _userData = UserData();
Widget _defaultHome = LogRegScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? _result = await _userData.getLogged();
  if (_result == true) {
    _defaultHome = Navigation();
  }
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
      home: _defaultHome,
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