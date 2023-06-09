abstract class LoginPageState {}

class LoginInitState extends LoginPageState{}

class EyeChange extends LoginPageState{}

class RegisterSuccess extends LoginPageState{}
class RegisterLoading extends LoginPageState{}
class RegisterError extends LoginPageState{
  final String error;
  RegisterError(this.error);
}

class CreationSuccess extends LoginPageState{}
class CreationLoading extends LoginPageState{}
class CreationError extends LoginPageState{
  final String error;
  CreationError(this.error);
}


class LoginSuccess extends LoginPageState{}
class LoginLoading extends LoginPageState{}
class LoginError extends LoginPageState{
  final String error;
  LoginError(this.error);
}