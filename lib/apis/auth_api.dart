import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserCredential> login(String email, String password) async {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> register(
      {required String email,
      required String password,
      required String name}) async {
    var userCred = await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCred.user != null) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(userCred.user!.uid)
          .set({
        "email": email,
        "name": name,
      });
    }

    return userCred;
  }

  Stream<User?> isLogin() {
    return auth.authStateChanges();
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
