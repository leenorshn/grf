import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grf/apis/operation_api.dart';
import 'package:grf/blocs/operation/operation_bloc.dart';
import 'package:pie_chart/pie_chart.dart';

class RapportScreen extends StatefulWidget {
  const RapportScreen({Key? key}) : super(key: key);

  @override
  State<RapportScreen> createState() => _RapportScreenState();
}

class _RapportScreenState extends State<RapportScreen> {
  final colorList = <Color>[
    Colors.red,
    Colors.blue,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Rapport"),
      ),
      body: BlocBuilder<OperationBloc, OperationState>(
        builder: (context, state) {
          if (state is OperationLoadedSuccess) {
            var depense = OperationApi.getDepense(state.data);
            var revenu = OperationApi.getRevenu(state.data);

            var rP = ((revenu - depense) / revenu) * 100;
            var dP = (depense / revenu) * 100;
            Map<String, double> dataMap = {
              "Depasse": dP,
              "Revenu": rP,
            };
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                  child: Text("Mois de Septembre"),
                ),
                PieChart(
                  dataMap: dataMap,
                  //centerText: "HYBRID",
                  totalValue: rP + dP,
                  chartType: ChartType.disc,
                  baseChartColor: Colors.grey[300]!,
                  colorList: colorList,
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Depasse",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "$depense \$",
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.red,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Revenu",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      "$revenu \$",
                      style: const TextStyle(
                        fontSize: 32,
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "Evaluation",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    getMessage(revenu: rP, depense: dP)
                  ],
                )
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  Text getMessage({required double revenu, required double depense}) {
    int equilibre = 10;
    if ((revenu + equilibre) < depense) {
      return const Text(
        "Tres mauvaise",
        style: TextStyle(
          fontSize: 24,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      );
    } else if ((revenu) < depense) {
      return const Text(
        "Mauvaise",
        style: TextStyle(
          fontSize: 24,
          color: Colors.red,
          fontWeight: FontWeight.w700,
        ),
      );
    } else if ((depense + equilibre) < revenu) {
      return const Text(
        "Tres bonne",
        style: TextStyle(
          fontSize: 24,
          color: Color(0xff21ce99),
          fontWeight: FontWeight.w700,
        ),
      );
    } else {
      return const Text(
        "Bonne",
        style: TextStyle(
          fontSize: 24,
          color: Color(0xff21ce99),
          fontWeight: FontWeight.w700,
        ),
      );
    }
  }
}
