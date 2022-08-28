import 'package:cloud_firestore/cloud_firestore.dart';

class Budget {
  String title;
  List<BItem> items;
  Timestamp date;

  Budget({
    required this.title,
    required this.items,
    required this.date,
  });

  factory Budget.fromJson(var json) {
    return Budget(
        title: json['title'], items: json['value'], date: json['date']);
  }

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "items": items.map((e) => e.toJson()),
      "date": date,
    };
  }

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

  factory BItem.fromJson(var json) {
    return BItem(label: json['label'], value: json['value']);
  }

  Map<String, dynamic> toJson() {
    return {
      "label": label,
      "value": value,
    };
  }
}
