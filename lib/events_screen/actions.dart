import 'package:flutter/cupertino.dart';

abstract class EvActions {}

class AddEvent extends EvActions {
  Action action;
  AddEvent({this.action});
}

class AcceptEvent extends EvActions {
  String eventId;
  String userId;
  AcceptEvent({this.eventId, this.userId});
}
