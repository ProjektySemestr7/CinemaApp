import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String id = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool card = false;

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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Imię',
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
                            'Nazwisko',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Uprawnienia',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),
                          Container(
                            width: 200,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  card = !card;
                                });
                              },
                              child: card
                                  ? Icon(
                                      Icons.local_play,
                                      color: Colors.blueAccent,
                                    )
                                  : Icon(
                                      Icons.close,
                                      color: Colors.blueAccent,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {},
                        child: Text('Zarejestruj'),
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
