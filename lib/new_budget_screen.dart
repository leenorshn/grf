import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewBudgetScreen extends StatefulWidget {
  const NewBudgetScreen({Key? key}) : super(key: key);

  @override
  State<NewBudgetScreen> createState() => _NewBudgetScreenState();
}

class _NewBudgetScreenState extends State<NewBudgetScreen> {
  double revenu = 0;
  String source = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Nouveau Budget',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          TextButton.icon(
            label: const Text('Enregister'),
            icon: const Icon(CupertinoIcons.checkmark_alt),
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              primary: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height / 2,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                onChanged: (v) {
                  setState(() {
                    revenu = double.parse(v);
                  });
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: "Revenu"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: TextField(
                onChanged: (v) {
                  setState(() {
                    source = v;
                  });
                },
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(labelText: "Source"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
