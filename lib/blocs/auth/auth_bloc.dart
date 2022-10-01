import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:grf/apis/auth_api.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthApi authService;
  StreamSubscription? subscription;
  AuthBloc({required this.authService}) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is StartAppEvent) {
        emit(AuthLoading());
        try {
          subscription?.cancel();
          subscription = authService.isLogin().listen((event) {
            if (event != null) {
              add(UpdateAuthState(event));
            }
          });
        } catch (ex) {
          emit(UnAuthenticated());
        }
      }

      if (event is UpdateAuthState) {
        // print(user.balance);
        emit(AuthSuccess(event.user));
      } else {
        emit(UnAuthenticated());
      }
      if (event is Login) {
        emit(AuthLoading());
        // await authService.signInWithGoogle();

        var user = await authService.login(
            email: "${event.phone}@mela.com", password: event.password);

        add(
          StartAppEvent(),
        );
      }
      if (event is Register) {
        emit(AuthLoading());
        // await authService.signInWithGoogle();
        var newUser = await authService.register(
          name: event.name,
          email: event.phone,
          password: event.password,
        );
        // print(user.user!.uid);

      }
      if (event is Logout) {
        emit(AuthLoading());
        await authService.logout();
        emit(UnAuthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    subscription?.cancel();
    return super.close();
  }
}
