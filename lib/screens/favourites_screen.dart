import 'package:cinema/storages/user_data.dart';
import 'package:cinema/widgets/favourite_tile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({Key? key}) : super(key: key);

  static const id = 'FavouriteScreen';

  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  final UserData _userData = UserData();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<String> _favouriteMoviesIds = [];
  String _email = '';
  final List<Dismissible> _dismissibles = [];
  late QuerySnapshot<Map<String, dynamic>>? _favouritesTable;

  void updateUserData() async {
    String? email = await _userData.getEmail();
    var favouritesTable = await _firestore
        .collection('userData')
        .doc(email)
        .collection("favourites")
        .get();

    final List<String> favouriteMovieIds = [];
    final List<String> favouriteIds = [];

    for (var favourite in favouritesTable.docs) {
      favouriteMovieIds.add(favourite['movieId']);
      favouriteIds.add(favourite.id);
    }

    setState(() {
      _email = email!;
      _favouriteMoviesIds = favouriteMovieIds;
      _favouritesTable = favouritesTable;
    });
  }

  @override
  void initState() {
    super.initState();
    updateUserData();
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
                  "Ulubione",
                  style: TextStyle(color: Colors.amberAccent, fontSize: 25),
                ),
              ),
            ),
            _email == ''
                ? Container()
                : StreamBuilder<QuerySnapshot>(
                    stream: _firestore.collection('movies').snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        final movies = snapshot.data!.docs;

                        for (var movie in movies) {
                          final name = movie['name'].toString();
                          final url = movie['image'].toString();
                          final movieId = movie.id;

                          if (_favouriteMoviesIds.contains(movieId)) {
                            final movieTile = FavouriteTile(
                              title: name,
                              url: url,
                            );

                            var favourite = _favouritesTable!.docs
                                .firstWhere((el) => el['movieId'] == movieId);

                            _dismissibles.add(Dismissible(
                              child: movieTile,
                              key: Key(favourite.id),
                              onDismissed: (direction) {
                                deleteFavourite(favourite.id);
                              },
                            ));
                          }
                        }

                        return Column(
                          children: _dismissibles,
                        );
                      }
                      return const CircularProgressIndicator();
                    },
                  ),
          ],
        ),
      ),
    );
  }

  void deleteFavourite(String id) async {
    _dismissibles.removeWhere((el) => el.key == Key(id));
    await _firestore
        .collection('userData')
        .doc(_email)
        .collection("favourites")
        .doc(id)
        .delete();
  }
}
