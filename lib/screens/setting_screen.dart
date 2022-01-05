import 'package:cinema/login/log_reg_screen.dart';
import 'package:cinema/storages/firestore_user_data.dart';
import 'package:cinema/storages/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const id = 'SettingsScreen';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FireStoreUserData _firestoreUserData = FireStoreUserData();
  final UserData _userData = UserData();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String _name = '';
  String _surname = '';
  late String _email = '';
  late bool _card = false;

  final TextEditingController _textEditingController = TextEditingController();

  _displayNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Zmień dane'),
            content: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: _name),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _name = _textEditingController.text;
                      _firestore
                          .collection('userData')
                          .doc(_email)
                          .update({'name': _name});
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Zmień')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Anuluj'))
            ],
          );
        });
  }

  _displaySurNameDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Zmień dane'),
            content: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(hintText: _surname),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _surname = _textEditingController.text;
                      _firestore
                          .collection('userData')
                          .doc(_email)
                          .update({'surname': _surname});
                      Navigator.of(context).pop();
                    });
                  },
                  child: const Text('Zmień')),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Anuluj'))
            ],
          );
        });
  }

  _displayCardDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Zmień dane'),
            content: SizedBox(
              width: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 50,
                    child: TextButton(
                      child: const Icon(
                        Icons.local_play,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          _card = true;
                          _firestore
                              .collection('userData')
                              .doc(_email)
                              .update({'card': _card});
                        });
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  SizedBox(
                    width: 50,
                    child: TextButton(
                      child: const Icon(
                        Icons.close,
                        color: Colors.blueAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          _card = false;
                          _firestore
                              .collection('userData')
                              .doc(_email)
                              .update({'card': _card});
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
                  child: const Text('Anuluj'))
            ],
          );
        });
  }

  Widget content() {
    if (_card == null) {
      return const Text('ładowanie');
    } else if (_card == true) {
      return const Icon(
        Icons.local_play,
        color: Colors.blueAccent,
      );
    } else {
      return const Icon(
        Icons.close,
        color: Colors.blueAccent,
      );
    }
  }

  void updateEmail(String? email) {
    setState(() {
      _email = email!;
    });
  }

  void updateName(String? name) {
    setState(() {
      _name = name!;
    });
  }

  void updateSurname(String? surname) {
    setState(() {
      _surname = surname!;
    });
  }

  void updateCard(bool? card) {
    setState(() {
      _card = card!;
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
                    const Text(
                      'Imię',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _displayNameDialog(context);
                        },
                        child: Text(
                          _name,
                          style:
                              TextStyle(color: Colors.blueAccent, fontSize: 15),
                        ),
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
                    const Text(
                      'Nazwisko',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: TextButton(
                        onPressed: () {
                          _displaySurNameDialog(context);
                        },
                        child: Text(
                          _surname,
                          style: const TextStyle(
                              color: Colors.blueAccent, fontSize: 15),
                        ),
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
                    const Text(
                      'Uprawnienia',
                      style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                    ),
                    Container(
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.blueAccent),
                      ),
                      child: TextButton(
                        onPressed: () {
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
                child: const Text('Wyloguj'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
