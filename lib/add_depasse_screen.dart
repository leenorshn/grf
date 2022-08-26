import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddDepasseScreen extends StatefulWidget {
  const AddDepasseScreen({Key? key}) : super(key: key);

  @override
  State<AddDepasseScreen> createState() => _AddDepasseScreenState();
}

class _AddDepasseScreenState extends State<AddDepasseScreen> {
  String libel = "";
  double montant = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouvelle depasse"),
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: TextField(
              onChanged: (v) {
                setState(() {
                  montant = double.parse(v);
                });
              },
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Montent",
                prefixIcon: Icon(CupertinoIcons.money_dollar),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
            child: TextField(
              onChanged: (v) {
                setState(() {
                  libel = v;
                });
              },
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(labelText: "Detail"),
              maxLength: 25,
            ),
          ),
          const SizedBox(
            height: 56,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 80),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {},
              child: Text("Enregister"),
            ),
          )
        ],
      ),
    );
  }
}
