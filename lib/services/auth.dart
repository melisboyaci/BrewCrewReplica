import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/services/database.dart';
import 'package:logger/logger.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Logger _logger = Logger();

  /* MyUser? _userfromFirebaseUser(User? user) {
    // ignore: unnecessary_null_comparison
    return user != null ? MyUser(uid: user.uid) : null;
  }*/

  Stream<User?> get userStream {
    // Örnek olarak FirebaseAuth'den bir stream döndürdüğünüzü varsayalım
    return FirebaseAuth.instance.authStateChanges();
  }

  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return user;
    } catch (e) {
      _logger.e("Hata oluştu: $e"); // Hata günlüğü
      return null;
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;
      await DatabaseService(uid: user!.uid).updateUserData('0', 'Melis', 900);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
