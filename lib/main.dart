import 'package:cinema/login/log_reg_screen.dart';
import 'package:cinema/login/login_screen.dart';
import 'package:cinema/login/register_screen.dart';
import 'package:cinema/screens/card_screen.dart';
import 'package:cinema/screens/home_screen.dart';
import 'package:cinema/screens/setting_screen.dart';
import 'package:cinema/screens/supporting/navigation.dart';
import 'package:cinema/storages/user_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

UserData _userData = UserData();
Widget _defaultHome = const LogRegScreen();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool? _result = await _userData.getLogged();
  if (_result == true) {
    _defaultHome = const Navigation();
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
        Navigation.id: (context) => const Navigation(),
        HomeScreen.id: (context) => const HomeScreen(),
        CardScreen.id: (context) => const CardScreen(),
        SettingsScreen.id: (context) => const SettingsScreen(),
        LogRegScreen.id: (context) => const LogRegScreen(),
        LogInScreen.id: (context) => const LogInScreen(),
        RegisterScreen.id: (context) => const RegisterScreen(),
      },
    );
  }
}
