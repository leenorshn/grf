import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grf/blocs/auth/auth_bloc.dart';
import 'package:grf/blocs/budget/budget_bloc.dart';
import 'package:grf/models/budget.dart';
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
        actions: [
          TextButton.icon(
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(Logout());
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.location, color: Colors.white),
            label: const Text(
              "Deconnexion",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
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
          BlocBuilder<BudgetBloc, BudgetState>(
            builder: (context, state) {
              if (state is BudgetLoadedFailure) {}
              if (state is BudgetLoadedSuccess) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        Budget b = state.data[index];
                        return Slidable(
                          key: const ValueKey(0),

                          // The start action pane is the one at the left or the top side.
                          startActionPane: ActionPane(
                            // A motion is a widget used to control how the pane animates.
                            motion: const ScrollMotion(),

                            // A pane can dismiss the Slidable.
                            dismissible: DismissiblePane(onDismissed: () {}),

                            // All actions are defined in the children parameter.
                            children: [
                              // A SlidableAction can have an icon and/or a label.
                              SlidableAction(
                                onPressed: (context) {
                                  BlocProvider.of<BudgetBloc>(context)
                                      .add(RemoveBudgetEvent(b.reference!.id));
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),

                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  BlocProvider.of<BudgetBloc>(context)
                                      .add(RemoveBudgetEvent(b.reference!.id));
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),

                          // The end action pane is the one at the right or the bottom side.

                          child: Container(
                            margin: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 16),
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
                              subtitle: Text("${b.totalBudget} \$"),
                              title: Text(
                                b.title!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              backgroundColor: Colors.red[50],
                              children: b.items!
                                  .map(
                                    (e) => ListTile(
                                      title: Text(e.label),
                                      leading: Text("${e.value} \$"),
                                      trailing: IconButton(
                                        icon: const Icon(CupertinoIcons
                                            .checkmark_alt_circle),
                                        onPressed: () {},
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        );
                      }),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    );
  }
}
