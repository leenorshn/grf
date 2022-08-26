import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class RapportScreen extends StatefulWidget {
  const RapportScreen({Key? key}) : super(key: key);

  @override
  State<RapportScreen> createState() => _RapportScreenState();
}

class _RapportScreenState extends State<RapportScreen> {
  Map<String, double> dataMap = {
    "Depasse": 760,
    "revenu": 540,
  };

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            child: Text("Mois de Septembre"),
          ),
          PieChart(
            dataMap: dataMap,
            chartType: ChartType.disc,
            baseChartColor: Colors.grey[300]!,
            colorList: colorList,
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              Text(
                "Depasse",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "740 \$",
                style: TextStyle(
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
            children: const [
              Text(
                "Revenu",
                style: TextStyle(fontSize: 20),
              ),
              Text(
                "540 \$",
                style: TextStyle(
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
            children: const [
              Text(
                "Evaluation",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Text(
                "Mauvaise",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.red,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
