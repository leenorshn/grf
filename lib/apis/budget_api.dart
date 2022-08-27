import 'package:grf/models/budget.dart';

class BudgetApi {
  List<Budget> budgetData = [
    Budget(
      title: "Budget Janvier",
      items: [
        BItem(
          label: "Construction",
          value: 3000,
        ),
        BItem(
          label: "Frais academic",
          value: 400,
        ),
        BItem(
          label: "Achat moto",
          value: 1000,
        ),
        BItem(
          label: "Imprevu",
          value: 500,
        ),
      ],
    ),
    Budget(
      title: "Budget Fevrier",
      items: [
        BItem(
          label: "Construction",
          value: 3000,
        ),
        BItem(
          label: "Famille",
          value: 250,
        ),
        BItem(
          label: "Entretien champ",
          value: 700,
        ),
        BItem(
          label: "Imprevu",
          value: 400,
        ),
      ],
    ),
  ];
}
