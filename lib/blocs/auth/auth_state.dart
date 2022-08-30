part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final User user;

  const Authenticated(this.user);
}

class UnAuthenticated extends AuthState {}

class AuthLoading extends AuthState {}
