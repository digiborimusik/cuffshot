import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';

class Event {
  String id;
  int stars;
  String title;
  String desc;
  List photosUrls;
  List acceptedUids;

  Event({this.title, this.desc, this.photosUrls, this.stars}) {
    String generateRandomString(int len) {
      var r = Random();
      const _chars =
          'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
      return List.generate(len, (index) => _chars[r.nextInt(_chars.length)])
          .join();
    }

    this.id = generateRandomString(20);
  }

  Event.fromRef(QueryDocumentSnapshot snapshot) {
    id = snapshot.id;
    stars = snapshot.data()['stars'];
    title = snapshot.data()['title'];
    desc = snapshot.data()['desc'];
    photosUrls = snapshot.data()['photosUrls'];
    acceptedUids = snapshot.data()['acceptedUids'];
    print(toMap);
  }

  Map get toMap {
    return {
      'acceptedUids': acceptedUids,
      'stars': stars,
      'title': title,
      'photosUrls': photosUrls,
      'desc': desc
    };
  }
}
