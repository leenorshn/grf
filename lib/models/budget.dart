import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Budget {
  String? title;
  List<BItem>? items;
  Timestamp? date;
  DocumentSnapshot? reference;

  Budget({
    this.title,
    this.items,
    this.date,
    this.reference,
  });

  Budget.fromJson(DocumentSnapshot snapshot, {this.reference}) {
    Map<String, dynamic> json = snapshot.data() as Map<String, dynamic>;
    title = json['title'];
    items = [];
    json['items'].forEach((v) {
      items!.add(BItem.fromJson(jsonDecode(v)));
    });
    date = json['date'];
  }

  Budget.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromJson(snapshot, reference: snapshot);

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "items": _toList(items!),
      "date": date,
    };
  }

  _toList(List<BItem> foods) {
    var json = [];
    foods.forEach((data) {
      json.add(jsonEncode(data.toJson()));
    });
    return json;
  }

  double getTotal() {
    double t = 0;
    for (var b in items!) {
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
