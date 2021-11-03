import 'package:cinema/storages/UserData.dart';
import 'package:cinema/widgets/Ticket.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  static final id = 'CardScreen';

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {

  UserData _userData = UserData();
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _email = '';

  void updateEmail(String? email){
    setState(() {
      this._email = email!;
    });
  }

  @override
  void initState() {
    _userData.getEmail().then(updateEmail);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blueAccent,
              child: Center(
                child: Text(
                  "Bilety",
                  style: TextStyle(
                    color: Colors.amberAccent,
                    fontSize: 25
                  ),
                ),
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: _firestore.collection('userData').doc(_email).collection('tickets').snapshots(),
              builder: (context, snapshot){
                if (snapshot.hasData){
                  final cards = snapshot.data!.docs;
                  List<Ticket> cardWidgets = [];

                  for (var card in cards) {
                    final movie = card['movie'];
                    final date = card['date'];
                    final row = card['row'];
                    final place = card['seat'];
                    final cinema = card['cinema'];
                    // final room = card['room'];

                    final cardWidget = Ticket(
                      movie: movie,
                      date: date,
                      row: row,
                      place: place,
                      cinema: cinema,
                      email: _email,
                    );
                    cardWidgets.add(cardWidget);
                  }
                  return Column(
                    children: cardWidgets,
                  );
                }
                return Container(
                  child: Text('Brak biletów'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
