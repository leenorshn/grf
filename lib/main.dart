import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grf/apis/auth_api.dart';
import 'package:grf/apis/budget_api.dart';
import 'package:grf/apis/operation_api.dart';
import 'package:grf/blocs/auth/auth_bloc.dart';
import 'package:grf/blocs/budget/budget_bloc.dart';
import 'package:grf/blocs/operation/operation_bloc.dart';
import 'package:grf/login_screen.dart';
import 'package:grf/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(authService: AuthApi())..add(StartAppEvent()),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  BudgetBloc(BudgetApi())..add(LoadBudgetEvent())),
          BlocProvider(
              create: (context) =>
                  OperationBloc(OperationApi())..add(LoadOpsEvent())),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.red,
            appBarTheme: const AppBarTheme(
              elevation: 1,
            ),
            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
          ),
          home: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthLoading) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }
              if (state is AuthSuccess) {
                return const MainScreen();
              }
              return const LoginScreen();
            },
          ),
        ),
      ),
    );
  }
}

class RootScreen extends StatelessWidget {
  const RootScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      //bloc: AuthBloc(authService: AuthService())..add(StartAppEvent()),
      builder: (context, state) {
        if (state is UnAuthenticated) {
          return const LoginScreen();
        }
        if (state is AuthSuccess) {
          //print(state.user);
          return const MainScreen();
        }
        if (state is AuthFailure) {
          return const LoginScreen();
        }

        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
