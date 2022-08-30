import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grf/models/budget.dart';

class BudgetApi {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Budget>> getOne() {
    var uid = auth.currentUser!.uid;
    return db
        .collection("users")
        .doc(uid)
        .collection("budgets")
        .orderBy("date", descending: true)
        .snapshots()
        .map(
          (event) => event.docs.map((e) => Budget.fromSnapshot(e)).toList(),
        );
  }

  Future<void> addBudget(Budget budget) async {
    var uid = auth.currentUser!.uid;
    await db
        .collection("users")
        .doc(uid)
        .collection("budgets")
        .add(budget.toJson());
  }

  Future<void> removeBudget(String id) async {
    var uid = auth.currentUser!.uid;
    await db
        .collection("users")
        .doc(uid)
        .collection("budgets")
        .doc(id)
        .delete();
  }
}
