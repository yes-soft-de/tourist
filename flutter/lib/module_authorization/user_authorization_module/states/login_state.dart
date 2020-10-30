class LoginState {}

class LoginStateSuccess extends LoginState {
  LoginStateSuccess();
}

class LoginStateError extends LoginState {
  String errMsg;
  LoginStateError(this.errMsg);
}

class LoginStateEmailSent extends LoginState {}
