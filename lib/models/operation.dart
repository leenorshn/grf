import 'package:cloud_firestore/cloud_firestore.dart';

class Operation {
  String libel;
  double montant;
  String type;
  Timestamp date;

  Operation({
    required this.montant,
    required this.libel,
    required this.date,
    required this.type,
  });

  factory Operation.fromJson(var json) {
    return Operation(
      montant: json['montant'],
      libel: json['libel'],
      date: json['date'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "montant": montant,
      "libel": libel,
      "date": date,
      "type": type,
    };
  }
}
