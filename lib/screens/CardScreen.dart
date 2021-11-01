import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  static final id = 'CardScreen';

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('Użytkownik/Karta'),
    );
  }
}
