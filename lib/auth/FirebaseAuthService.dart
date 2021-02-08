import 'package:cuffshot/auth/FirebaseStatusData.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Authorization service
// Returns data that contains Login status, user data or error-code
class FirebaseAuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Sign in by email and password
  Future<FirebaseStatusData> signIn(String email, String pass) async {
    // Check data for empty
    if (email == null || pass == null || email == '' || pass == '') {
      return FirebaseStatusData(
          false, auth.currentUser, 'Empty email or password');
    }

    try {
      await auth.signInWithEmailAndPassword(email: email, password: pass);
      return FirebaseStatusData(true, auth.currentUser, null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return FirebaseStatusData(false, auth.currentUser, 'User not found');
      } else if (e.code == 'invalid-email') {
        return FirebaseStatusData(false, auth.currentUser, 'Invalid email');
      } else if (e.code == 'too-many-requests') {
        return FirebaseStatusData(
            false, auth.currentUser, 'To many request, chill some');
      } else if (e.code == 'wrong-password') {
        return FirebaseStatusData(false, auth.currentUser, 'Wrong password');
      } else {
        print('Another error in sign in: ' + e.code.toString());
        return FirebaseStatusData(false, auth.currentUser, 'Empty exception');
      }
    } catch (e) {
      print('Another error in sign in: ' + e.code.toString());
      return FirebaseStatusData(false, auth.currentUser, 'Unhandled error');
    }
  }

  // Register by email and password
  Future<FirebaseStatusData> regIn(String email, String pass) async {
    // Check data for empty
    if (email == null || pass == null || email == '' || pass == '') {
      return FirebaseStatusData(
          false, auth.currentUser, 'Empty email or password');
    }

    try {
      await auth.createUserWithEmailAndPassword(email: email, password: pass);
      return FirebaseStatusData(true, auth.currentUser, null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return FirebaseStatusData(
            false, auth.currentUser, 'Email already in use');
      } else if (e.code == 'invalid-email') {
        return FirebaseStatusData(false, auth.currentUser, 'Invalid email');
      } else if (e.code == 'too-many-requests') {
        return FirebaseStatusData(
            false, auth.currentUser, 'To many requests, chill some');
      } else if (e.code == 'weak-password') {
        return FirebaseStatusData(false, auth.currentUser, 'Week password');
      } else {
        print('Another error in reg in: ' + e.code.toString());
        return FirebaseStatusData(false, auth.currentUser, 'Empty exception');
      }
    } catch (e) {
      print('Another error in sign in: ' + e.code.toString());
      return FirebaseStatusData(false, auth.currentUser, 'Unhandled error');
    }
  }

  Future<FirebaseStatusData> checkSingStatus() async {
    User user = auth.currentUser;

    if (user != null) {
      return FirebaseStatusData(true, auth.currentUser, null);
    } else {
      return FirebaseStatusData(false, auth.currentUser, null);
    }
  }

  Future signOut() async {
    await auth.signOut();
    return FirebaseStatusData(false, auth.currentUser, null);
  }

  Future<FirebaseStatusData> updateUserData(
      String displayName, String photoUrl) async {
    try {
      await auth.currentUser
          .updateProfile(displayName: displayName, photoURL: photoUrl);
      return FirebaseStatusData(true, auth.currentUser, null);
    } catch (e) {
      print('Error in update data');
      return FirebaseStatusData(true, auth.currentUser, 'error');
    }
  }
}
