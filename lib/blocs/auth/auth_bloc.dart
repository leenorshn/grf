import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grf/apis/auth_api.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi authApi;
  StreamSubscription? subscription;
  AuthBloc(this.authApi) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AppStartedEvent) {
        emit(UnAuthenticated());
        // emit(AuthLoading());

        try {
          subscription = authApi.isLogin().listen((event) {
            if (event != null) {
              add(UpdateAuthStateEvent(event));
            } else {
              add(LogoutEvent());
            }
          });
        } on Exception {
          emit(UnAuthenticated());
        }
      }
      if (event is UpdateAuthStateEvent) {
        print("${event.user.uid}**************");
        emit(Authenticated(event.user));
      }
      if (event is RegisterEvent) {
        await authApi.register(
            email: event.email, password: event.password, name: event.name);
        add(AppStartedEvent());
      }
      if (event is LoginEvent) {
        await authApi.login(event.email, event.password);
        add(AppStartedEvent());
      }
      if (event is LogoutEvent) {
        await authApi.logout();
        emit(UnAuthenticated());
      }
    });
  }
}
