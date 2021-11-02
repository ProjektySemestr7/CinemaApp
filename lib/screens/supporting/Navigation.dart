import 'package:cinema/screens/CardScreen.dart';
import 'package:cinema/screens/HomeScreen.dart';
import 'package:cinema/screens/SettingScreen.dart';
import 'package:cinema/storages/UserData.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  static final id = 'Navigation';

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 1;
  List<Widget> pages = [CardScreen(), HomeScreen(), SettingsScreen()];

  UserData _userData = UserData();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String _email = '';
  String _password = '';

  void updateEmail(String? email) {
    setState(() {
      this._email = email!;
    });
  }

  void updatePassword(String? password) {
    setState(() {
      this._password = password!;
    });
  }

  void tryLogin(String email, String password) async {
    if (email != '' && password != '') {
      try {
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        print('Zalogowano');
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    _userData.getEmail().then(updateEmail);
    _userData.getPassword().then(updatePassword);
    tryLogin(_email, _password);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amberAccent,
        title: Text('Kino'),
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.amberAccent,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                  child: Icon(
                    Icons.local_play,
                    size: _selectedIndex == 0 ? 35 : 25,
                    color: _selectedIndex == 0 ? Colors.green : Colors.grey,
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 1;
                    });
                  },
                  child: Icon(
                    Icons.home,
                    size: _selectedIndex == 1 ? 35 : 25,
                    color: _selectedIndex == 1 ? Colors.green : Colors.grey,
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                  child: Icon(
                    Icons.settings,
                    size: _selectedIndex == 2 ? 35 : 25,
                    color: _selectedIndex == 2 ? Colors.green : Colors.grey,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
