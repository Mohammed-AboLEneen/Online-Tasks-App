abstract class RegisterStates {}

class InitRegisterState extends RegisterStates {}

class SuccessRegisterState extends RegisterStates {}

class FailureRegisterState extends RegisterStates {
  final String message;

  FailureRegisterState(this.message);
}

class LoadingRegisterState extends RegisterStates {}
