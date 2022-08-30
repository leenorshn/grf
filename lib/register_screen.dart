import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grf/blocs/auth/auth_bloc.dart';
import 'package:grf/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name = "";
  String email = "";
  String password = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 64,
              ),
              const Text(
                "Compte GRF",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(
                height: 64,
              ),
              TextField(
                onChanged: (v) {
                  setState(() {
                    name = v;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(CupertinoIcons.person),
                  labelText: "Identite",
                  hintText: "Natha kakoko",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                onChanged: (v) {
                  setState(() {
                    email = v;
                  });
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(CupertinoIcons.mail),
                  labelText: "Email",
                  hintText: "nath@grf.cd",
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextField(
                onChanged: (v) {
                  setState(() {
                    password = v;
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(CupertinoIcons.lock),
                  labelText: "Password",
                ),
                maxLength: 8,
              ),
              const SizedBox(
                height: 64,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.black,
                ),
                onPressed: () {
                  if (email == "" && password.length < 8 && name.length < 3) {
                    print("Erreur champ vide");
                  } else {
                    BlocProvider.of<AuthBloc>(context).add(RegisterEvent(
                        email: email, password: password, name: name));
                  }
                },
                child: const Text("creer compte"),
              ),
              const SizedBox(
                height: 32,
              ),
              TextButton(
                style: TextButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  primary: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen()));
                },
                child: const Text(" soit connectez-vous"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
