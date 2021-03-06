import 'package:cinema/screens/supporting/navigation.dart';
import 'package:cinema/storages/user_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const String id = 'RegisterScreen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final UserData _userData = UserData();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  bool card = false;
  late String _email = '';
  late String _password = '';
  late String _name = '';
  late String _surname = '';

  bool _allow = false;

  void checkAllow() {
    if ((_email.isNotEmpty) &&
        (_password.isNotEmpty) &&
        (_name.isNotEmpty) &&
        (_surname.isNotEmpty)) {
      setState(() {
        _allow = true;
      });
    } else {
      setState(() {
        _allow = false;
      });
    }
  }

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
                          const Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              onChanged: (input) {
                                _email = input;
                                checkAllow();
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Has??o',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              obscureText: true,
                              onChanged: (input) {
                                _password = input;
                                checkAllow();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Imi??',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              onChanged: (input) {
                                _name = input;
                                checkAllow();
                              },
                            ),
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Nazwisko',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextField(
                              onChanged: (input) {
                                _surname = input;
                                checkAllow();
                              },
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Uprawnienia',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),
                          SizedBox(
                            width: 200,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  card = !card;
                                });
                              },
                              child: card
                                  ? const Icon(
                                      Icons.local_play,
                                      color: Colors.blueAccent,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      color: Colors.blueAccent,
                                    ),
                            ),
                          ),
                        ],
                      ),
                      _allow
                          ? ElevatedButton(
                              onPressed: () async {
                                try {
                                  final newUser = await _auth
                                      .createUserWithEmailAndPassword(
                                          email: _email, password: _password);
                                  _firestore
                                      .collection('userData')
                                      .doc(_email)
                                      .set({
                                    'name': _name,
                                    'surname': _surname,
                                    'card': card
                                  });
                                  if (newUser != null) {
                                    _userData.saveEmail(_email);
                                    _userData.savePassword(_password);

                                    _userData.saveLogged(true);

                                    Navigator.pushNamed(context, Navigation.id);
                                  }
                                } catch (e) {
                                  print(e);
                                }
                              },
                              child: const Text('Zarejestruj'),
                            )
                          : Container(),
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
