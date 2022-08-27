class Budget {
  String title;
  List<BItem> items;

  Budget({required this.title, required this.items});

  double getTotal() {
    double t = 0;
    for (var b in items) {
      t = t + b.value;
    }
    return t;
  }

  double get totalBudget => getTotal();
}

class BItem {
  String label;
  double value;

  BItem({this.value = 0, required this.label});
}
