import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class Ticket extends StatefulWidget {
  const Ticket({Key? key, required this.movie, required this.cinema, required this.date, required this.row, required this.place, required this.email}) : super(key: key);

  final String movie;
  final String cinema;
  final String date;
  final String row;
  final String place;
  final String email;

  @override
  _TicketState createState() => _TicketState();
}

class _TicketState extends State<Ticket> {

  bool _show = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.cinema),
                  Text(widget.date),
                ],
              ),
            ),
            Text(
              widget.movie,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.amberAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rząd ${widget.row} miejsce: ${widget.place}'),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _show = !_show;
                        });
                      },
                      child: Text('QR', style: TextStyle(color: Colors.black),)
                  ),
                ],
              ),
            ),
            _show ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                child: QrImage(
                  data: '{'
                      'email: ${this.widget.email},'
                      'movie: ${this.widget.movie},'
                      'row: ${this.widget.row},'
                      'place: ${this.widget.place},'
                      'cinema: ${this.widget.cinema},'
                      'date: ${this.widget.date}'
                      '}',
                  backgroundColor: Colors.white,
                  version: QrVersions.auto,
                ),
              ),
            ) : Container(),
          ],
        ),
      ),
    );
  }
}
