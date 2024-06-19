import 'package:chat/service/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_model.dart';

class AuthService {
  //? class convert to singleton
  static AuthService? _instance;
  factory AuthService() => _instance ??= AuthService._();
  AuthService._();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  MyUser? _currentUser;
  MyUser? get currentUser => MyUser.fromFirebaseUser(_firebaseAuth.currentUser!);

  Stream<User?> get user {
    return _firebaseAuth.authStateChanges();
  }

  Future<void> resetPassword({
    required String email,
  }) async {
    return await _firebaseAuth.sendPasswordResetEmail(email: email);
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential? userCredential;
    userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    if (userCredential.user != null) {
      _currentUser = MyUser.fromFirebaseUser(userCredential.user!);
      firestoreService.addUser(_currentUser!);
    }
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _currentUser = MyUser.fromFirebaseUser(user.user!);
    } catch ( e ) {
      debugPrint(e.toString());
    }
  }

  Future<void> logOut() async {
    return await _firebaseAuth.signOut();
  }
}

AuthService authService = AuthService();
