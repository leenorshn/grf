import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grf/apis/budget_api.dart';
import 'package:uuid/uuid.dart';

class NewBudgetScreen extends StatefulWidget {
  const NewBudgetScreen({Key? key}) : super(key: key);

  @override
  State<NewBudgetScreen> createState() => _NewBudgetScreenState();
}

class _NewBudgetScreenState extends State<NewBudgetScreen> {
  double revenu = 0;
  String title = "";
  List<Map<String, String>> fields = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Nouveau Budget"),
      ),
      body: SafeArea(
        child: Container(
          //height: MediaQuery.of(context).size.height / 2,
          color: Colors.white,
          margin: const EdgeInsets.only(top: 24),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                  ),
                  child: TextField(
                    onChanged: (v) {
                      setState(() {
                        title = v;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Entrer le titre ici",
                    ),
                    style: const TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  "Liste de tache",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                for (var i = 0; i < fields.length; i++)
                  Padding(
                    key: ValueKey(fields[i].keys.first),
                    padding: const EdgeInsets.only(top: 6.0),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 26,
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              suffix: Icon(
                                CupertinoIcons.money_dollar,
                                size: 16,
                              ),
                              hintText: "0.00",
                              hintStyle: TextStyle(
                                color: Colors.black87,
                              ),
                            ),
                            onChanged: (v) {},
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          flex: 5,
                          child: TextField(
                            onChanged: (v) {},
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            _removeField(i);
                          },
                          icon: const Icon(CupertinoIcons.minus_circle),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(
                  height: 46,
                ),
                TextButton.icon(
                  onPressed: () {
                    _addNewField();
                  },
                  label: const Text("Ajouter element"),
                  icon: const Icon(CupertinoIcons.add),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 56,
                      vertical: 20,
                    ),
                  ),
                  onPressed: () {},
                  child: const Text("enregistrer"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addNewField() {
    fields.add({const Uuid().v1(): ""});
    setState(() {});
  }

  _removeField(int index) {
    fields.removeAt(index);
    setState(() {});
  }
}
