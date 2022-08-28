import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:grf/apis/auth_api.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi authApi;
  StreamSubscription? subscription;
  AuthBloc(this.authApi) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AppStartedEvent) {
        emit(AuthLoading());

        try {
          subscription =
              authApi.isLogin().listen((event) => add(UpdateAuthStateEvent()));
        } on Exception {
          emit(UnAuthenticated());
        }
      }
      if (event is UpdateAuthStateEvent) {
        emit(Authenticated());
      }
      if (event is RegisterEvent) {
        await authApi.register(
            email: event.email, password: event.password, name: event.name);
      }
      if (event is LoginEvent) {
        await authApi.login(event.email, event.password);
      }
      if (event is LogoutEvent) {
        await authApi.logout();
      }
    });
  }
}
