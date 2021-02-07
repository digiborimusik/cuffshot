import 'package:firebase_auth/firebase_auth.dart';

// Abstract state with busy functionaloty
abstract class AuthState {
  bool busy;
  AuthState({this.busy = false});

  copy(bool busy);
}

// Logined state
// Contains user instance
class IsLogined extends AuthState {
  User user;
  IsLogined({bool busy = false, this.user}) : super(busy: busy);

  @override
  copy(bool busy) {
    return IsLogined(busy: busy);
  }
}

// Logout state
// Contains error value to indicate error when false to login or register
class IsNotLogged extends AuthState {
  bool error;
  String code;
  IsNotLogged({bool busy = false, this.error = false, this.code})
      : super(busy: busy);

  @override
  copy(bool busy) {
    return IsNotLogged(busy: busy, error: error, code: code);
  }
}

// App starting state
class AppStarting extends AuthState {
  AppStarting({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return AppStarting(busy: busy);
  }
}
