abstract class AuthAction {}

class AppStart extends AuthAction {}

class SignIn extends AuthAction {
  String email;
  String password;
  SignIn(this.email, this.password);
}

class SignOut extends AuthAction {}

class Register extends AuthAction {
  String email;
  String password;
  Register(this.email, this.password);
}

class UpdateData extends AuthAction {
  String displayName;
  String imgUrl;
  UpdateData(this.displayName, this.imgUrl);
}
