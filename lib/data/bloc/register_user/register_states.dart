abstract class RegisterUserStates {}

class RegisterUserInitialState extends RegisterUserStates {}

class RegisterUserLoadingState extends RegisterUserStates {}

class RegisterUserLoadedState extends RegisterUserStates {}

class RegisterUserErrorState extends RegisterUserStates {
  String errorMsg;

  RegisterUserErrorState({required this.errorMsg});
}
