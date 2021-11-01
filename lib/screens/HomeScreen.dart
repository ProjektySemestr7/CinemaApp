import 'package:cinema/widgets/MovieTile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  static final id = 'HomeScreen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blueAccent),
      child: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Repertuar'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('movies').snapshots(),
              builder: (context, snapshot) {

                if(snapshot.hasData){
                  final cards = snapshot.data!.docs;

                  List<MovieTile> cardWidgets = [];

                  for(var card in cards) {
                    final name = card['name'].toString();
                    final url = card['image'].toString();
                    var now = DateTime.now();
                    final date = card['date'].toDate();
                    final diff = now.isAfter(date);

                    if (diff){
                      final cardWidget = MovieTile(
                        title: name,
                        url: url,
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }

                  return Expanded(
                    flex: 1,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: cardWidgets,
                      ),
                  );
                }
                return Container(
                  child: Text('Brak filmów'),
                );
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Zobacz już wkrótce'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('movies').snapshots(),
              builder: (context, snapshot) {

                if(snapshot.hasData){
                  final cards = snapshot.data!.docs;

                  List<MovieTile> cardWidgets = [];

                  for(var card in cards) {
                    final name = card['name'].toString();
                    final url = card['image'].toString();
                    var now = DateTime.now();
                    final date = card['date'].toDate();
                    final diff = now.isBefore(date);

                    if (diff){

                      final cardWidget = MovieTile(
                        title: name,
                        url: url,
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }

                  return Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: cardWidgets,
                    ),
                  );
                }
                return Container(
                  child: Text('Brak filmów'),
                );
              },
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('Zobacz przedpremierowo!'),
            ),
            StreamBuilder<QuerySnapshot>(
              stream: firestore.collection('movies').snapshots(),
              builder: (context, snapshot) {

                if(snapshot.hasData){
                  final cards = snapshot.data!.docs;

                  List<MovieTile> cardWidgets = [];

                  for(var card in cards) {
                    final name = card['name'].toString();
                    final url = card['image'].toString();
                    final early = card['early'];
                    var now = DateTime.now();
                    final date = card['date'].toDate();
                    final diff = now.isBefore(date);

                    if (diff && early){

                      final cardWidget = MovieTile(
                        title: name,
                        url: url,
                      );
                      cardWidgets.add(cardWidget);
                    }
                  }

                  return Expanded(
                    flex: 1,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: cardWidgets,
                    ),
                  );
                }
                return Container(
                  child: Text('Brak filmów'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
