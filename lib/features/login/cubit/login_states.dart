abstract class LoginStates {}

class InitialState extends LoginStates {}

class LoadingState extends LoginStates {}

class SuccessState extends LoginStates {}

class FailedState extends LoginStates {
  final String errMsg;

  FailedState({required this.errMsg});

}
