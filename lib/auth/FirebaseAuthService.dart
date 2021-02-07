import 'package:cuffshot/auth/FirebaseStatusData.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Authorization service
// Returns data that contains Login status, user data or error-code
class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Sign in by email and password
  Future<FirebaseStatusData> signIn(String email, String pass) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return FirebaseStatusData(true, auth.currentUser, null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return FirebaseStatusData(false, auth.currentUser, e.code);
      } else if (e.code == 'wrong-password') {
        return FirebaseStatusData(false, auth.currentUser, e.code);
      } else {
        print('Another error in sign in: ' + e.code.toString());
        return FirebaseStatusData(false, auth.currentUser, 'unhandled-error');
      }
    }
  }

  // Register by email and password
  Future<FirebaseStatusData> regIn(String email, String pass) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      return FirebaseStatusData(true, auth.currentUser, null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return FirebaseStatusData(false, auth.currentUser, e.code);
      } else if (e.code == 'invalid-email') {
        return FirebaseStatusData(false, auth.currentUser, e.code);
      } else if (e.code == 'weak-password') {
        return FirebaseStatusData(false, auth.currentUser, e.code);
      } else {
        print('Another error in reg in: ' + e.code.toString());
        return FirebaseStatusData(false, auth.currentUser, 'unhandled-error');
      }
    }
  }

  Future signOut() async {
    await auth.signOut();
    return FirebaseStatusData(false, auth.currentUser, null);
  }

  Future updateUserData(String displayName, String photoUrl) {
    auth.currentUser
        .updateProfile(displayName: displayName, photoURL: photoUrl);
    try {} catch (e) {}
  }
}
