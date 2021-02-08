import 'dart:async';
import 'dart:math';
// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cuffshot/events/EvActions.dart';
import 'package:cuffshot/events/Event.dart';
import 'package:rxdart/rxdart.dart';

class EventsBloc {
  // Init firebase, open stream to events and declare subscribtion for raw data
  // Sub declared for disposable
  // raw data from stream will parse and then pass to RxStream as list of events instanses
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot> collectionStream;
  StreamSubscription streamSub;

  // Stream of parsed events list
  BehaviorSubject<List<Event>> _eventsChanell = BehaviorSubject.seeded([]);
  Stream<List<Event>> get eventsStream => _eventsChanell.stream;

  EventsBloc() {
    // Opening stream
    collectionStream = firestore.collection('events').snapshots();
    // Subscribing for data
    streamSub = collectionStream.listen((event) {
      List events = event.docs.map((e) => Event.fromRef(e)).toList();
      _eventsChanell.sink.add(events);
    });
  }

  void mapEvent(EvActions act) {}

  void dispose() {
    streamSub.cancel();
    _eventsChanell.close();
  }
}
