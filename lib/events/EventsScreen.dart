import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({Key key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference ads;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ads = FirebaseFirestore.instance.collection('appCollection');
  }

  void asd() async {
    // print(ads.add({'asdasd': 123123}));
    // DocumentReference docref = ads.doc('data');
    // DocumentSnapshot doc = await docref.get();
    // docref.update({'asd': 989889});
    QuerySnapshot collectionRef = await ads.get();
    var collectionMap = (collectionRef.docs.map((e) => e.data())).first;
    print(collectionMap);
  }

  @override
  Widget build(BuildContext context) {
    asd();
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Text('data'),
    );
  }
}
