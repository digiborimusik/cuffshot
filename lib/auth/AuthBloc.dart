import 'package:cuffshot/auth/AuthActions.dart';
import 'package:cuffshot/auth/AuthStates.dart';
import 'package:cuffshot/auth/FirebaseAuthService.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc {
  FirebaseAuthService fAuthSrv = FirebaseAuthService();
  AuthState initialState = AppStarting();
  BehaviorSubject<AuthState> _state;

  AuthBloc() {
    _state = BehaviorSubject<AuthState>.seeded(initialState);
  }

  get state => _state.stream;

  Future<void> mapEvent(AuthAction act) async {}
}
