import 'package:cinema/widgets/bottom_widget.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class MovieTile extends StatefulWidget {
  final String url;
  final String title;
  final String movieId;

  const MovieTile(
      {Key? key, required this.url, required this.title, required this.movieId})
      : super(key: key);

  @override
  _MovieTileState createState() => _MovieTileState();
}

class _MovieTileState extends State<MovieTile> {
  String image = '';

  Future downloadImage() async {
    Reference ref = FirebaseStorage.instance.ref().child(widget.url);
    String downloadedURL = await ref.getDownloadURL();
    setState(() {
      image = downloadedURL;
    });
  }

  @override
  void initState() {
    downloadImage();
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: GestureDetector(
        onTap: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return Bottom(
                    url: image, title: widget.title, movieId: widget.movieId);
              });
        },
        child: SizedBox(
          child: Align(
            alignment: Alignment.topLeft,
            child: image != ""
                ? Image.network(image)
                : const CircularProgressIndicator(),
          ),
          width: MediaQuery.of(context).size.width / 4,
        ),
      ),
    );
  }
}
