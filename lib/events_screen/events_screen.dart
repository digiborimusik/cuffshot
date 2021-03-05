import 'package:cuffshot/modules/event.dart';
import 'package:cuffshot/events_screen/event_list_tile.dart';
import 'package:cuffshot/events_screen/events_bloc.dart';
import 'package:flutter/material.dart';

class EventsScreen extends StatefulWidget {
  EventsScreen({Key key}) : super(key: key);

  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventsBloc evBloc;

  @override
  void initState() {
    super.initState();
    evBloc = EventsBloc();
  }

  void asd() async {}

  @override
  Widget build(BuildContext context) {
    asd();
    return Scaffold(
      endDrawer: Drawer(
        child: AppDrawer(),
      ),
      appBar: AppBar(title: Text('Events')),
      body: StreamBuilder(
        stream: evBloc.eventsStream,
        builder: (context, AsyncSnapshot<List<Event>> snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: snapshot.data.map((e) => EventTile(e)).toList(),
            );
          } else {
            return Text('nodata');
          }
        },
      ),
    );
  }
}

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[900],
      child: ListView(
        children: [
          FlatButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AddingEventDialog(),
                );
              },
              child: Text('add'))
        ],
      ),
    );
  }
}

class AddingEventDialog extends StatelessWidget {
  // Uint8List imageData;
  // ImageDialog(this.imageData);

  @override
  Widget build(BuildContext context) {
    return Dialog(
        // backgroundColor: Colors.blueGrey[900],
        child: ListView(
      children: [TextField()],
    ));
  }
}
