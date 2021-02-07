import 'package:firebase_auth/firebase_auth.dart';

class FirebaseStatusData {
  final bool isLogined;
  final User user;
  final String reasonCode;

  FirebaseStatusData(this.isLogined, this.user, this.reasonCode);
}
