import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/models/user.dart';
import 'package:firebase_tutorial/service/database.dart';
import 'package:flutter/cupertino.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  // create user base on firebase
  Users _userFromFirebaseUser(User user) {
    return Users(uid: user.uid);
  }

  // auth change user stream
  Stream<Users> get users {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user!));
  }

  // sign in anonymous
  Future<Users> signInAnonymous() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      debugPrint('Auth error (Sign in anonymous): ${e.code}');
      return Users(uid: '');
    }
  }

  // sign in with email and password
  Future<Users> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      return _userFromFirebaseUser(user!);
    } on FirebaseAuthException catch (e) {
      debugPrint('Auth error (Sign in with email and password): ${e.code}');
      return Users(uid: '');
    }
  }

  // register in with email and password
  Future<Users> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;
      // create new doc for user with uid
      // ! here make return dont't need it again
      await DatabaseService(uid: user!.uid)
          .updateUserData('0', 'new user', 100);
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      debugPrint('Auth error (Register with email and password): ${e.code}');
      return Users(uid: '');
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      debugPrint('Auth error (Sign out): ${e.code}');
      return null;
    }
  }
}
