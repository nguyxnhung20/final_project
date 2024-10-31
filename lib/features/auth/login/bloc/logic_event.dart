part of 'logic_bloc.dart';

class ForgotPassword extends LoginEvent {
  final String username;
  ForgotPassword({
    required this.username,
  });
}

abstract class LoginEvent {}

class LoginWithThirdParty extends LoginEvent {
  final bool isGoogle;
  LoginWithThirdParty({
    required this.isGoogle,
  });
}

class LoginWithUsernamePassword extends LoginEvent {
  final String username;
  final String pasword;
  LoginWithUsernamePassword({
    required this.username,
    required this.pasword,
  });
}
