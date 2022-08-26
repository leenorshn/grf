import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grf/add_depasse_screen.dart';
import 'package:grf/models/charge.dart';
import 'package:grf/rapport_screen.dart';
import 'package:grf/setting_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(140),
        child: Column(
          children: [
            AppBar(
              title: const Text("Gestion Financiere "),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RapportScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  icon: const Icon(
                    CupertinoIcons.chart_bar_circle,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingScreen(),
                        fullscreenDialog: true,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.settings,
                  ),
                )
              ],
            ),
            Expanded(
              child: Container(
                color: Colors.red,
                child: Row(
                  children: [
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Solde actuel",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "400 \$",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "(Salaire/mois)",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 60,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Dépasse",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "47.5 \$",
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: chargesData.length,
        itemExtent: 88,
        padding: const EdgeInsets.only(bottom: 130),
        itemBuilder: (context, index) {
          Charge charge = chargesData[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(top: 1),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            child: Center(
              child: ListTile(
                trailing: CircleAvatar(
                  backgroundColor: Colors.red[50],
                  child: const Icon(
                    CupertinoIcons.arrow_up,
                    color: Colors.black,
                  ),
                ),
                leading: Text.rich(
                  TextSpan(
                    text: "${charge.montant} ",
                    children: const [
                      TextSpan(
                        text: "\$",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                title: Text("${charge.libele} "),
                onTap: () {},
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40,
        ),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddDepasseScreen(),
                fullscreenDialog: true,
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 88),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: const Text(
            "Ajouter depasse",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
