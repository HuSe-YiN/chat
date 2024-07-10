import 'package:chat/screens/home_page.dart';
import 'package:chat/screens/login.dart';
import 'package:chat/service/firestore_user_service.dart';
import 'package:chat/util/extensions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

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
      fUserService.addUser(_currentUser!);
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
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> logOut(BuildContext context) async {
    await _firebaseAuth.signOut();

    GoogleSignIn().signOut();
    if (context.mounted) {
      context.pushAndRemoveUntil(const Login());
    }
  }

  Future googleSignIn(BuildContext context) async {
    final GoogleSignInAccount? googleUser;
    try {
      googleUser = await GoogleSignIn().signIn();
    } catch (e) {
      return;
    }
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final OAuthCredential credential = GoogleAuthProvider.credential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

      final UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);

      _currentUser = MyUser.fromFirebaseUser(userCredential.user!);
      fUserService.addUser(_currentUser!);

      if (context.mounted) {
        context.pushAndRemoveUntil(const HomePage());
      }
    }
  }
}

AuthService authService = AuthService();
