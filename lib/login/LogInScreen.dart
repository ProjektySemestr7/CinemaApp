import 'package:flutter/material.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  static const String id = 'LogInScreen';

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.amberAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: TextField(),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Hasło',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: TextField(),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Zaloguj'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
