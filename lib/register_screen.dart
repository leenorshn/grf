import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      body: ListView(
        children: [
          const SizedBox(
            height: 64,
          ),
          const Text(
            "Grf",
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
            onChanged: (v) {},
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
            onChanged: (v) {},
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
            onChanged: (v) {},
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
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              primary: Colors.black,
            ),
            onPressed: () {},
            child: const Text("login"),
          ),
          const SizedBox(
            height: 32,
          ),
          TextButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              primary: Colors.white,
            ),
            onPressed: () {},
            child: const Text(" soit connectez-vous"),
          ),
        ],
      ),
    );
  }
}
