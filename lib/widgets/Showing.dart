import 'package:cinema/storages/UserData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Showing extends StatefulWidget {
  const Showing(
      {Key? key,
      required this.date,
      required this.movie,
      required this.city,
      required this.id})
      : super(key: key);

  final String date;
  final String movie;
  final String city;
  final String id;

  @override
  _ShowingState createState() => _ShowingState();
}

class _ShowingState extends State<Showing> {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  UserData _userData = UserData();

  String _selectedRow = '--';
  String _selectedPlace = '--';
  late String _email;
  bool _allow = false;

  void checkAllow() {
    if (_selectedPlace != '--' && _selectedPlace != '--') {
      setState(() {
        _allow = true;
      });
    }
  }

  void updateEmail(String? email) {
    setState(() {
      _email = email!;
    });
  }

  @override
  void initState() {
    _userData.getEmail().then(updateEmail);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (_) => StatefulBuilder(builder: (context, setState) {
                  return AlertDialog(
                    title: Text('Kupujesz bilet?'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Film: ${this.widget.movie}\nData: ${this.widget.date}\nKino: ${this.widget.city}\nRząd: $_selectedRow Miejsce: $_selectedPlace',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                        Container(
                          height: 50,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection('showings')
                                    .doc(this.widget.id)
                                    .collection('seats')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final cards = snapshot.data!.docs;
                                    List<DropdownMenuItem<String>> seats = [];

                                    for (var card in cards) {
                                      final title = card.id.toString();
                                      final cardWidget = DropdownMenuItem(
                                        child: Text(title),
                                        value: '$title',
                                      );
                                      seats.add(cardWidget);
                                    }
                                    return DropdownButton(
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                      items: seats,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedRow = value.toString();
                                        });
                                        checkAllow();
                                      },
                                      hint: Text(
                                        _selectedRow,
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      child: Text('Brak miejsc'),
                                    );
                                  }
                                },
                              ),
                              StreamBuilder<QuerySnapshot>(
                                stream: _firestore
                                    .collection('showings')
                                    .doc(this.widget.id)
                                    .collection('seats')
                                    .doc(_selectedRow)
                                    .collection('place')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    final cards = snapshot.data!.docs;
                                    List<DropdownMenuItem<String>> seats = [];

                                    for (var card in cards) {
                                      final title = card.id.toString();
                                      final available = card['available'];
                                      final cardWidget = DropdownMenuItem(
                                        child: Text(title),
                                        value: '$title',
                                      );
                                      seats.add(cardWidget);
                                    }
                                    return DropdownButton(
                                      style:
                                          TextStyle(color: Colors.blueAccent),
                                      items: seats,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedPlace = value.toString();
                                        });
                                        checkAllow();
                                      },
                                      hint: Text(
                                        _selectedPlace,
                                        style:
                                            TextStyle(color: Colors.blueAccent),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      child: Text('Brak miejsc'),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (_allow) {
                            String data =
                                widget.date.replaceAll('/', '').trim();
                            _firestore
                                .collection('userData')
                                .doc(_email)
                                .collection('tickets')
                                .doc(data.replaceAll(' ', ''))
                                .set({
                              'date': widget.date,
                              'movie': widget.movie,
                              'cinema': widget.city,
                              'row': _selectedRow,
                              'seat': _selectedPlace
                            });
                            Navigator.pop(context);
                          }
                        },
                        child: const Text('Tak!',
                            style: TextStyle(color: Colors.blueAccent)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Anuluj',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      )
                    ],
                  );
                }));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amberAccent,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Container(
          child: Text(
            widget.date,
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
        ),
      ),
    );
  }
}
