import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthApi {
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserCredential> login({required String email,required String password}) async {
    return auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> register(
      {required String email,
      required String password,
      required String name}) async {
    var userCred = await auth.createUserWithEmailAndPassword(
      email: email+"@mela.com",
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
    return auth.idTokenChanges();
  }

  Future<void> logout() async {
    await auth.signOut();
  }
}
