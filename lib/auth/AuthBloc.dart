import 'package:cuffshot/auth/AuthActions.dart';
import 'package:cuffshot/auth/AuthStates.dart';
import 'package:cuffshot/auth/FirebaseAuthService.dart';
import 'package:cuffshot/auth/FirebaseStatusData.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  FirebaseAuthService fAuthSrv = FirebaseAuthService();

  // Stream of state
  BehaviorSubject<AuthState> _stateChanell =
      BehaviorSubject.seeded(AppStarting());
  Stream<AuthState> get stateStream => _stateChanell.stream;

  // State
  AuthState _state = AppStarting();
  AuthState get state => this._state;
  set state(AuthState newState) {
    _state = newState;
    _stateChanell.sink.add(newState);
  }

  // Constructor
  AuthBloc() {
    mapEvent(AppStart());
  }

  // Actions handler
  Future<void> mapEvent(AuthAction act) async {
    // Mark current state as busy
    state = state.copy(true);

    if (act is AppStart) {
      FirebaseStatusData status = await fAuthSrv.checkSingStatus();
      status.isLogined
          ? state = IsLogined(user: status.user)
          : state = IsNotLogged();
    }

    if (act is SignIn) {
      FirebaseStatusData status =
          await fAuthSrv.signIn(act.email, act.password);
      status.isLogined
          ? state = IsLogined(user: status.user)
          : state = IsNotLogged(error: true, code: status.reasonCode);
    }

    if (act is Register) {
      FirebaseStatusData status = await fAuthSrv.regIn(act.email, act.password);
      status.isLogined
          ? state = IsLogined(user: status.user)
          : state = IsNotLogged(error: true, code: status.reasonCode);
    }

    if (act is SignOut) {
      FirebaseStatusData status = await fAuthSrv.signOut();
      status.isLogined
          ? state = IsLogined(user: status.user)
          : state = IsNotLogged(error: false, code: null);
    }

    if (act is UpdateData) {
      FirebaseStatusData status =
          await fAuthSrv.updateUserData(act.displayName, act.imgUrl);
      status.isLogined
          ? state = IsLogined(user: status.user)
          : state = IsNotLogged(error: false, code: null);
    }
  }

  void dispose() {
    _stateChanell.close();
  }
}
