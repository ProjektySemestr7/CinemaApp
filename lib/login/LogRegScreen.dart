import 'package:cinema/login/LoginScreen.dart';
import 'package:cinema/login/RegisterScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LogRegScreen extends StatelessWidget {
  const LogRegScreen({Key? key}) : super(key: key);

  static const String id = 'log_rec_screen';

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Masz już konto?',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),

            SizedBox(
              height: 50,
            ),

            Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, LogInScreen.id);
                },
                child: Text(
                  'Zaloguj',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
            ),

            SizedBox(
              height: 50,
            ),

            Text(
              'lub',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent),
            ),

            SizedBox(
              height: 50,
            ),

            Container(
              width: 250,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.amberAccent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
                child: Text(
                  'Zarejestruj',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
