import 'package:cinema/widgets/Showing.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Bottom extends StatefulWidget {
  const Bottom({Key? key, required this.url, required this.title})
      : super(key: key);

  final String url;
  final String title;

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedCinema = "--";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.amberAccent.withOpacity(0.3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                maxRadius: MediaQuery.of(context).size.height / 6,
                backgroundImage: NetworkImage(widget.url),
              ),
              Text(
                widget.title,
                style: TextStyle(color: Colors.blueAccent, fontSize: 30),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('cinemas').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cards = snapshot.data!.docs;
                    List<DropdownMenuItem<String>> cinemas = [];

                    for (var card in cards) {
                      final title = card.id;
                      final cardWidget = DropdownMenuItem(
                        child: Text(title),
                        value: "$title",
                      );
                      cinemas.add(cardWidget);
                    }
                    return DropdownButton(
                      items: cinemas,
                      onChanged: (value) {
                        setState(() {
                          _selectedCinema = value.toString();
                        });
                      },
                      style: TextStyle(
                        color: Colors.blueAccent,
                      ),
                      hint: Text(
                        _selectedCinema,
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    );
                  } else {
                    return Container(
                      child: Text('Brak kin'),
                    );
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('showings').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cards = snapshot.data!.docs;
                    List<Showing> showings = [];
                    for (var card in cards) {
                      var formatter = new DateFormat('dd/MM/yyyy hh:mm');
                      final date =
                          formatter.format(card['start'].toDate()).toString();
                      final movieT = card['movie'].toString();
                      final cinemaT = card['cinema'].toString();
                      final id = card.id.toString();
                      final cardWidget = Showing(
                        date: date,
                        id: id,
                        city: cinemaT,
                        movie: movieT,
                      );

                      if (movieT == widget.title &&
                          cinemaT == _selectedCinema) {
                        showings.add(cardWidget);
                      }
                    }
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        children: showings,
                      ),
                    );
                  } else {
                    return Container(
                      child: Text('Brak pokazów'),
                    );
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
