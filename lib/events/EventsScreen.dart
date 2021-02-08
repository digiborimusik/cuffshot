import 'package:cuffshot/events/EventsBloc.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({Key key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventsBloc evBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    evBloc = EventsBloc();
  }

  void asd() async {}

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
