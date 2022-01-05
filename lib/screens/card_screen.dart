import 'package:cinema/storages/user_data.dart';
import 'package:cinema/widgets/ticket_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardScreen extends StatefulWidget {
  const CardScreen({Key? key}) : super(key: key);

  static const id = 'CardScreen';

  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  final UserData _userData = UserData();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _email = '';

  void updateEmail() async {
    String? email = await _userData.getEmail();
    setState(() {
      _email = email!;
    });
  }

  @override
  void initState() {
    super.initState();
    updateEmail();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Colors.blueAccent,
              child: const Center(
                child: Text(
                  "Bilety",
                  style: TextStyle(color: Colors.amberAccent, fontSize: 25),
                ),
              ),
            ),
            _email == ''
                ? Container()
                : StreamBuilder<QuerySnapshot>(
                    stream: _firestore
                        .collection('userData')
                        .doc(_email)
                        .collection('tickets')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final cards = snapshot.data!.docs;
                        List<Ticket> tickets = [];

                        for (var card in cards) {
                          final movie = card['movie'];
                          final date = card['date'];
                          final row = card['row'];
                          final place = card['seat'];
                          final cinema = card['cinema'];

                          DateFormat dateFormat =
                              DateFormat("DD/MM/yyyy HH:mm");
                          DateTime parsedDate = dateFormat.parse(date);
                          DateTime now = DateTime.now();
                          bool isActive = now.isBefore(parsedDate);

                          final ticket = Ticket(
                            movie: movie,
                            date: date,
                            row: row,
                            place: place,
                            cinema: cinema,
                            email: _email,
                            isActive: isActive,
                          );
                          tickets.add(ticket);
                        }
                        return Column(
                          children: tickets,
                        );
                      }
                      return const Text('Brak biletów');
                    },
                  ),
          ],
        ),
      ),
    );
  }
}
