import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grf/apis/budget_api.dart';
import 'package:grf/models/revenu.dart';
import 'package:grf/new_budget_screen.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String frequence = "mois";
  String source = "";
  double revenu = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Parametre"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              top: 12,
              right: 16,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Budgets"),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const NewBudgetScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                  ),
                  icon: const Icon(CupertinoIcons.plus),
                  label: const Text("Ajouter"),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            padding: const EdgeInsets.symmetric(
              vertical: 6,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(6),
            ),
            child: ExpansionTile(
              subtitle: Text("${t.totalBudget} \$"),
              title: Text(
                t.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              backgroundColor: Colors.red[50],
              children: t.items
                  .map(
                    (e) => ListTile(
                      title: Text(e.label),
                      leading: Text("${e.value} \$"),
                      trailing: IconButton(
                        icon: const Icon(CupertinoIcons.checkmark_alt_circle),
                        onPressed: () {},
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
