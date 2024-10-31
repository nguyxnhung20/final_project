part of 'logic_bloc.dart';

class FailedLoginState extends LoginState {
  final String? errorMessage;
  FailedLoginState({
    this.errorMessage,
  });
}

class InitialLoginState extends LoginState {}

class LoadingLoginState extends LoginState {}

abstract class LoginState {}

class SuccessfullyLoginState extends LoginState {
  final String? successfulMsg;
  SuccessfullyLoginState({
    this.successfulMsg,
  });
}
