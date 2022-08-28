import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grf/models/operation.dart';

class OperationApi {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  Stream<List<Operation>> getAll() {
    var uid = auth.currentUser!.uid;
    return db
        .collection("users")
        .doc(uid)
        .collection("operations")
        .orderBy("date", descending: true)
        .snapshots()
        .map(
          (event) =>
              event.docs.map((e) => Operation.fromJson(e.data())).toList(),
        );
  }

  Future<void> addBudget(Operation operation) async {
    var uid = auth.currentUser!.uid;
    await db
        .collection("users")
        .doc(uid)
        .collection("budgets")
        .add(operation.toJson());
  }
}
