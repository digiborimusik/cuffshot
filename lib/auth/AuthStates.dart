abstract class AuthState {
  bool busy;
  AuthState({this.busy = false});

  copy(bool busy);
}

class IsLogined extends AuthState {
  IsLogined({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return IsLogined(busy: busy);
  }
}

class IsNotLogged extends AuthState {
  IsNotLogged({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return IsNotLogged(busy: busy);
  }
}

class AppStarting extends AuthState {
  AppStarting({bool busy = false}) : super(busy: busy);

  @override
  copy(bool busy) {
    return AppStarting(busy: busy);
  }
}
