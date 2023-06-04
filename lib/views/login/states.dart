import '../../core/api_services/user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final User user;

  LoginSuccessState({required this.user});
}

class LoginErrorState extends LoginStates {
  final String error;

  LoginErrorState(this.error);
}
