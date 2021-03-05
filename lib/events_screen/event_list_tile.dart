import 'dart:typed_data';

import 'package:cuffshot/modules/event.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class EventTile extends StatefulWidget {
  final Event _event;
  EventTile(this._event);

  @override
  _EventTileState createState() => _EventTileState();
}

class _EventTileState extends State<EventTile> {
  FirebaseStorage _storage;

  @override
  void initState() {
    super.initState();
    _storage = FirebaseStorage.instance;
  }

  List<Widget> get stars {
    List<Widget> stars = [];

    for (var i = 0; i < widget._event.stars; i++) {
      stars.add(Icon(
        Icons.star,
        color: Color(0xffFFD700),
      ));
    }

    return stars;
  }

  Future<List<Widget>> get photos async {
    List<Widget> photos = [];

    for (var i = 0; i < widget._event.stars; i++) {
      Reference ref = _storage.ref('/eventsImages/criminal_t_650x433.jpg');
      Uint8List imageData = await ref.getData();

      Future<Widget> imageBlock() async {
        return GestureDetector(
          onTap: () async {
            showDialog(
                context: context, builder: (_) => ImageDialog(imageData));
          },
          child: Container(
              // color: Colors.red,
              padding: EdgeInsets.all(8),
              // height: 200,
              child: Image.memory(imageData)),
        );
      }

      photos.add(await imageBlock());
    }

    return photos;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            widget._event.title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: stars,
          ),
        ),
        Container(
          height: 120,
          child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: FutureBuilder(
                future: photos,
                initialData: null,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Row(children: snapshot.data);
                  } else if (snapshot.data == null) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Text('no data');
                  }
                },
              )),
        ),
        Text(widget._event.desc)
      ],
    );
  }
}

class ImageDialog extends StatelessWidget {
  Uint8List imageData;
  ImageDialog(this.imageData);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      // backgroundColor: Colors.blueGrey[900],
      child: InteractiveViewer(
        // panEnabled: false, // Set it to false to prevent panning.
        // boundaryMargin: EdgeInsets.all(1),
        minScale: 1,
        maxScale: 4,
        child: SizedBox(
            // height: double.infinity,
            width: double.infinity,
            child: Image.memory(imageData)),
      ),
    );
  }
}
