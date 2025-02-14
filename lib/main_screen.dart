import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grf/add_depasse_screen.dart';
import 'package:grf/add_revenu_screen.dart';
import 'package:grf/apis/operation_api.dart';
import 'package:grf/blocs/operation/operation_bloc.dart';
import 'package:grf/models/operation.dart';
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
                      children: [
                        const Text(
                          "Solde actuel",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        BlocBuilder<OperationBloc, OperationState>(
                          builder: (context, state) {
                            if (state is OperationLoadedSuccess) {
                              var solde = OperationApi.getSolde(state.data);
                              return Text(
                                "$solde \$",
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        ),
                        const Text(
                          "(actifs/mois)",
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
                      children: [
                        const Text(
                          "Dépasse",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        BlocBuilder<OperationBloc, OperationState>(
                          builder: (context, state) {
                            if (state is OperationLoadedSuccess) {
                              var depense = OperationApi.getDepense(state.data);
                              return Text(
                                "$depense \$",
                                style: const TextStyle(
                                  fontSize: 32,
                                  color: Colors.white,
                                ),
                              );
                            }
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          },
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
      body: BlocBuilder<OperationBloc, OperationState>(
        builder: (context, state) {
          if (state is OperationLoadedFailure) {
            return Center(
              child: Text("Erreur de chargement"),
            );
          }

          if (state is OperationLoadedSuccess) {
            return ListView.builder(
              itemCount: state.data.length,
              itemExtent: 88,
              padding: const EdgeInsets.only(bottom: 130),
              itemBuilder: (context, index) {
                Operation operation = state.data[index];
                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(top: 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  child: Center(
                    child: ListTile(
                      trailing: CircleAvatar(
                        backgroundColor: operation.type == "depense"
                            ? Colors.red[50]
                            : Colors.green[50],
                        child: operation.type == "depense"
                            ? const Icon(
                                CupertinoIcons.arrow_up,
                                color: Colors.red,
                              )
                            : const Icon(
                                CupertinoIcons.arrow_down,
                                color: Colors.green,
                              ),
                      ),
                      leading: Text.rich(
                        TextSpan(
                          text: "${operation.montant} ",
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
                      title: Text("${operation.libel} "),
                      onTap: () {},
                    ),
                  ),
                );
              },
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(CupertinoIcons.arrow_down),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AddRevenuScreen(),
                      fullscreenDialog: true,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                label: const Text(
                  "Ajouter Revenu",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Expanded(
              child: ElevatedButton.icon(
                icon: const Icon(CupertinoIcons.arrow_up),
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
                  elevation: 0,
                  primary: Colors.black,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                  ),
                ),
                label: const Text(
                  "Ajouter depense",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
