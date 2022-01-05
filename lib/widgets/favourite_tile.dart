import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FavouriteTile extends StatefulWidget {
  final String url;
  final String title;

  const FavouriteTile({Key? key, required this.url, required this.title})
      : super(key: key);

  @override
  _FavouriteTileState createState() => _FavouriteTileState();
}

class _FavouriteTileState extends State<FavouriteTile> {
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
        onTap: () {},
        child: Column(
          children: [
            SizedBox(
              child: Align(
                alignment: Alignment.topLeft,
                child: image != ""
                    ? Image.network(image)
                    : const Text("Ładowanie"),
              ),
              width: MediaQuery.of(context).size.width / 4,
            ),
          ],
        ),
      ),
    );
  }
}
