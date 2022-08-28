part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class AppStartedEvent extends AuthEvent {}

class UpdateAuthStateEvent extends AuthEvent {}

class RegisterEvent extends AuthEvent {
  final String email;
  final String password;
  final String name;

  const RegisterEvent(
      {required this.name, required this.email, required this.password});
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}
