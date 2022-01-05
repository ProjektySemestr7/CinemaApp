import 'package:cinema/storages/user_data.dart';
import 'package:cinema/widgets/showing_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Bottom extends StatefulWidget {
  const Bottom(
      {Key? key, required this.url, required this.title, required this.movieId})
      : super(key: key);

  final String url;
  final String title;
  final String movieId;

  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Bottom> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String _selectedCinema = "--";
  final UserData _userData = UserData();
  String _email = '';
  bool _isFavourite = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    var email = await _userData.getEmail();
    var isFavourite = await checkExist(email!, widget.movieId);

    setState(() {
      _email = email;
      _isFavourite = isFavourite;
    });
  }

  Future<bool> checkExist(String email, String movieId) async {
    var favsCollection = await _firestore
        .collection('userData')
        .doc(email)
        .collection('favourites')
        .get();

    for (var fav in favsCollection.docs) {
      if (fav['movieId'] == movieId) {
        return true;
      }
    }

    return false;
  }

  void updateFavourite() async {
    var favouriteExist = await checkExist(_email, widget.movieId);

    if (favouriteExist) {
      var favoritesCollection = await _firestore
          .collection('userData')
          .doc(_email)
          .collection('favourites')
          .get();

      var favourite = favoritesCollection.docs
          .firstWhere((el) => el['movieId'] == widget.movieId);

      await _firestore
          .collection('userData')
          .doc(_email)
          .collection("favourites")
          .doc(favourite.id)
          .delete();
    } else {
      await _firestore
          .collection('userData')
          .doc(_email)
          .collection('favourites')
          .add({'movieId': widget.movieId});
    }

    setState(() {
      _isFavourite = !_isFavourite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.amberAccent.withOpacity(0.5),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 10),
                  child: IconButton(
                    icon: Icon(Icons.favorite,
                        size: 35,
                        color: _isFavourite ? Colors.redAccent : Colors.white),
                    onPressed: () => {updateFavourite()},
                  ),
                ),
              ]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  maxRadius: MediaQuery.of(context).size.height / 6,
                  backgroundImage: NetworkImage(widget.url),
                ),
              ),
              Text(
                widget.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.blueAccent,
                  letterSpacing: 1.1,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
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
                        value: title,
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
                      style: const TextStyle(
                        color: Colors.blueAccent,
                      ),
                      hint: Text(
                        _selectedCinema,
                        style: const TextStyle(color: Colors.blueAccent),
                      ),
                    );
                  } else {
                    return const Text('Brak kin');
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('showings').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final cards = snapshot.data!.docs;
                    List<Showing> showings = [];
                    for (var card in cards) {
                      var formatter = DateFormat('dd/MM/yyyy hh:mm');
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
                    return const Text('Brak pokazów');
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
