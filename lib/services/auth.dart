import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      dynamic result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return result;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Sign in with email and passport
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      dynamic result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      return result;
    } catch (err) {
      print(err.toString());
      return null;
    }
  }
}
