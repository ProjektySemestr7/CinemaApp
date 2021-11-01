import 'package:cinema/screens/CardScreen.dart';
import 'package:cinema/screens/HomeScreen.dart';
import 'package:cinema/screens/SettingScreen.dart';
import 'package:flutter/material.dart';

class Navigation extends StatefulWidget {
  const Navigation({Key? key}) : super(key: key);

  static final id = 'Navigation';

  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex=1;
  List<Widget> pages = [CardScreen(), HomeScreen(), SettingsScreen()];

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
              TextButton(onPressed: () {
                setState(() {
                  _selectedIndex = 0;
                });
              }, child: Icon(
                Icons.local_play,
                size: _selectedIndex == 0 ? 35 : 25,
                color: _selectedIndex == 0 ? Colors.green : Colors.grey,
              )),
              TextButton(onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              }, child: Icon(
                Icons.home,
                size: _selectedIndex == 1 ? 35 : 25,
                color: _selectedIndex == 1 ? Colors.green : Colors.grey,
              )),
              TextButton(onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              }, child: Icon(
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
