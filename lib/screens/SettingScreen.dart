import 'package:cinema/login/LogRegScreen.dart';
import 'package:cinema/storages/FireStoreUserData.dart';
import 'package:cinema/storages/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static final id = 'SettingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FireStoreUserData _firestoreUserData = FireStoreUserData();
  UserData _userData = UserData();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _name = '';
  String _surname = '';
  late String _email;
  late bool _card;

  TextEditingController _textEditingController = TextEditingController();

  _displayNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Zmień dane'),
            content: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: _name
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _name = _textEditingController.text;
                      _firestore.collection('userData').doc(_email).update({'name': _name});
                      Navigator.of(context).pop();
                    });
                  }, 
                  child: Text('Zmień')
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Anuluj')
              )
            ],
          );
        }
        );
  }

  _displaySurNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Zmień dane'),
            content: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                  hintText: _surname
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _surname = _textEditingController.text;
                      _firestore.collection('userData').doc(_email).update({'surname': _surname});
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text('Zmień')
              ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Anuluj')
              )
            ],
          );
        }
    );
  }

  _displayCardDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text('Zmień dane'),
            content: Container(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 50,
                    child: TextButton(
                      child: Icon(Icons.local_play, color: Colors.blueAccent,),
                      onPressed: () {
                        setState(() {
                          _card = true;
                          _firestore.collection('userData').doc(_email).update({'card': _card});
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Container(
                    width: 50,
                    child: TextButton(
                      child: Icon(Icons.close, color: Colors.blueAccent,),
                      onPressed: () {
                        setState(() {
                          _card = false;
                          _firestore.collection('userData').doc(_email).update({'card': _card});
                        });
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            ),
            actions: [
              // TextButton(
              //     onPressed: () {
              //       setState(() {
              //         _name = _textEditingController.text;
              //         _firestore.collection('userData').doc(_email).update({'name': _name});
              //         Navigator.of(context).pop();
              //       });
              //     },
              //     child: Text('Zmień')
              // ),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Anuluj')
              )
            ],
          );
        }
    );
  }

  Widget content() {
    if (_card == null) {
      return Text('ładowanie');
    } else if (_card == true) {
      return Icon(Icons.local_play, color: Colors.blueAccent,);
    } else {
      return Icon(Icons.close, color: Colors.blueAccent,);
    }
  }

  void updateEmail(String? email) {
    setState(() {
      this._email = email!;
    });
  }

  void updateName(String? name) {
    setState(() {
      this._name = name!;
    });
  }

  void updateSurname(String? surname) {
    setState(() {
      this._surname = surname!;
    });
  }

  void updateCard(bool? card) {
    setState(() {
      this._card = card!;
    });
  }

  void fireBaseUserData(bool? logged) {
    if (logged == true) {
      _firestoreUserData.getUserName().then(updateName);
      _firestoreUserData.getUserSurName().then(updateSurname);
      _firestoreUserData.getUserCard().then(updateCard);
      _userData.getEmail().then(updateEmail);
    }
  }

  @override
  void initState() {
    _userData.getLogged().then(fireBaseUserData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: Colors.amberAccent,
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Imię',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                      ),
                      child: TextButton(
                        onPressed: (){
                          _displayNameDialog(context);
                        },
                        child: Text(_name,
                          style: TextStyle(color: Colors.blueAccent, fontSize: 15),),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nazwisko',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                      ),
                      child: TextButton(
                        onPressed: (){
                          _displaySurNameDialog(context);
                        },
                        child: Text(_surname,
                          style: TextStyle(color: Colors.blueAccent, fontSize: 15),),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Uprawnienia',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.blueAccent
                        ),
                      ),
                      child: TextButton(
                        onPressed: (){
                          _displayCardDialog(context);
                        },
                        child: content(),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () {
                    _auth.signOut();
                    _userData.saveLogged(false);
                    Navigator.pushNamed(context, LogRegScreen.id);
                  },
                child: Text('Wyloguj'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
