import 'package:firebase_auth/firebase_auth.dart';

class AuthFirebase {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String> signIn(String email, String password) async {
    AuthResult authResult = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }

  Future<String> createUser(String email, String password) async {
    AuthResult authResult = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    return authResult.user.uid;
  }

  Future<String> currentUser() async {
    FirebaseUser firebaseUser = await firebaseAuth.currentUser();
    return firebaseUser != null ? firebaseUser.uid : null;
  }

  void signOut() async {
    return firebaseAuth.signOut();
  }
}