import 'package:cinema/screens/supporting/Navigation.dart';
import 'package:cinema/storages/UserData.dart';
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

  UserData _userData = UserData();
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  bool card = false;
  late String _email;
  late String _password;
  late String _name;
  late String _surname;

  bool _allow = false;

  void checkAllow() {
    if((_email != null) && (_password != null) && (_name != null) && (_surname != null)) {
      setState(() {
        _allow = true;
      });
    }
    else {
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
                          Text(
                            'Email',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),

                          Container(
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
                          Text(
                            'Hasło',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),

                          Container(
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
                          Text(
                            'Imię',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),

                          Container(
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
                          Text(
                            'Nazwisko',
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 25,
                            ),
                          ),

                          Container(
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
                              onPressed: (){
                                setState(() {
                                  card = !card;
                                });
                              },
                              child: card ? Icon(Icons.local_play,
                              color: Colors.blueAccent,):Icon(Icons.close,
                                color: Colors.blueAccent,),
                            ),
                          ),

                        ],
                      ),

                      _allow ?ElevatedButton(
                        onPressed: () async{
                          _userData.saveLogged(true);
                          try {
                            final newUser = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);
                            _firestore.collection('userData').doc(_email).set({
                              'name':_name,
                              'surname':_surname,
                              'card':card
                            });
                            if (newUser != null) {
                              _userData.saveEmail(_email);
                              _userData.savePassword(_password);

                              Navigator.pushNamed(context, Navigation.id);
                            }
                          } catch (e) {
                            print(e);
                          }
                        },
                        child: Text('Zarejestruj'),
                      ) : Container(),
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
