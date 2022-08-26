import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grf/models/revenu.dart';

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
                const Text("Mes sources de revenus"),
                ElevatedButton.icon(
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Container(
                          height: MediaQuery.of(context).size.height / 2,
                          color: Colors.white,
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: Colors.red,
                                height: 56,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Nouvelle source',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextButton.icon(
                                      label: const Text('Enregister'),
                                      icon: const Icon(
                                          CupertinoIcons.checkmark_alt),
                                      onPressed: () => Navigator.pop(context),
                                      style: TextButton.styleFrom(
                                        primary: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: TextField(
                                  onChanged: (v) {
                                    setState(() {
                                      revenu = double.parse(v);
                                    });
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                      labelText: "Revenu"),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 40, vertical: 10),
                                child: TextField(
                                  onChanged: (v) {
                                    setState(() {
                                      source = v;
                                    });
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                      labelText: "Source"),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
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
          for (var t in revenuData)
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
              child: ListTile(
                leading: Text("${t.montant} \$/${t.frequence}"),
                title: Text(
                  t.source,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                trailing: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.edit),
                ),
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
