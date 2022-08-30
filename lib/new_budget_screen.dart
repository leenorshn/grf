import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grf/apis/budget_api.dart';
import 'package:grf/blocs/budget/budget_bloc.dart';
import 'package:grf/models/budget.dart';
import 'package:uuid/uuid.dart';

class NewBudgetScreen extends StatefulWidget {
  const NewBudgetScreen({Key? key}) : super(key: key);

  @override
  State<NewBudgetScreen> createState() => _NewBudgetScreenState();
}

class _NewBudgetScreenState extends State<NewBudgetScreen> {
  double revenu = 0;
  String title = "";
  String annee = "2022";
  String moi = "Janvier";
  List<BItem> fields = [];

  var moths = <String>[
    "Janvier",
    "Fevrier",
    "Mars",
    "Avril",
    "Mais",
    "Juin",
    "Juillet",
    "Aout",
    "Septembre",
    "Octobre",
    "Novembre",
    "Decembre"
  ];

  var annees = <String>["2022", "2023", "2024", "2025", "2026", "2027"];

  _updateField(BItem item, int index) {}
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
                    child: Row(
                      children: [
                        Expanded(
                          child: DropdownButton<String>(
                            value: moi,
                            isExpanded: true,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                moi = newValue!;
                              });
                            },
                            items: moths
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          width: 16,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            value: annee,
                            isExpanded: true,
                            elevation: 16,
                            onChanged: (String? newValue) {
                              setState(() {
                                annee = newValue!;
                              });
                            },
                            items: annees
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    )),
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
                for (var t = 0; t < fields.length; t++)
                  BItemTile(
                      item: fields[t],
                      onTap: () {
                        _removeField(t);
                      }),
                const SizedBox(
                  height: 46,
                ),
                TextButton.icon(
                  onPressed: () {
                    var label = "";
                    double value = 0;
                    var error = "";
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: TextField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (v) {
                                          setState(() {
                                            value = double.parse(v);
                                          });
                                        },
                                        decoration: const InputDecoration(
                                            hintText: "0.0",
                                            suffixIcon: Icon(
                                                CupertinoIcons.money_dollar)),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: TextField(
                                        onChanged: (v) {
                                          setState(() {
                                            label = v;
                                          });
                                        },
                                        decoration: const InputDecoration(
                                          hintText: "libel",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 72,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 16,
                                      horizontal: 72,
                                    ),
                                  ),
                                  onPressed: () {
                                    if (label.length > 3 && value > 0) {
                                      _addNewField(label, value);
                                    } else {
                                      setState(() {
                                        error = "veuillez completer ce champ";
                                      });
                                    }

                                    // Navigator.pop(context);
                                  },
                                  child: const Text("Ajouter"),
                                ),
                                const SizedBox(
                                  height: 32,
                                ),
                                Text(error),
                                const SizedBox(
                                  height: 32,
                                ),
                              ],
                            ),
                          );
                        });
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
                  onPressed: () {
                    if (fields.isNotEmpty) {
                      BlocProvider.of<BudgetBloc>(context).add(
                        AddBudgetEvent(
                          Budget(
                            date: Timestamp.now(),
                            title: "Budget $moi - $annee",
                            items: fields,
                          ),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text("enregistrer"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _addNewField(String label, double value) {
    BItem bItem = BItem(label: label, value: value);
    fields.add(bItem);
    setState(() {});
    Navigator.pop(context);
  }

  _removeField(int index) {
    fields.removeAt(index);
    setState(() {});
  }
}

class BItemTile extends StatelessWidget {
  const BItemTile({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);
  final BItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text("${item.value} \$"),
      title: Text(item.label),
      trailing: IconButton(
        icon: const Icon(
          CupertinoIcons.minus_circle,
          color: Colors.red,
        ),
        onPressed: onTap,
      ),
    );
  }
}
