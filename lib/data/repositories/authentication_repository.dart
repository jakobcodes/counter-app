import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:testapp/data/models/user.dart';

class RegisterFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogInWithGoogleFailure {}

class LogOutFailure implements Exception {}

class AuthenticationRepository {
  AuthenticationRepository({firebase_auth.FirebaseAuth? firebaseAuth, GoogleSignIn? googleSignIn}) {
    _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance;
    _googleSignIn = googleSignIn ?? GoogleSignIn.standard();
  }

  late final firebase_auth.FirebaseAuth _firebaseAuth;
  late final GoogleSignIn _googleSignIn;

  @visibleForTesting
  bool isWeb = kIsWeb;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      return user;
    });
  }

  // get UID
  String getCurrentUID() {
    return _firebaseAuth.currentUser!.toUser.id;
  }

  // get email
  String? getCurrentEmail() {
    return _firebaseAuth.currentUser!.toUser.email;
  }

  // get username
  String? getCurrentUsername() {
    return _firebaseAuth.currentUser!.toUser.username;
  }

  // get username
  String? getCurrentDisplayName() {
    return _firebaseAuth.currentUser!.displayName;
  }


  Future<void> registerWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw RegisterFailure();
    }
  }

  Future<void> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithGoogle () async {
    try {
      late final firebase_auth.AuthCredential credential;
      if (isWeb) {
        final googleProvider = firebase_auth.GoogleAuthProvider();
        final userCredential = await _firebaseAuth.signInWithPopup(googleProvider,);
        credential = userCredential.credential!;
      } else {
        final googleUser = await _googleSignIn.signIn();
        final googleAuth = await googleUser!.authentication;
        credential = firebase_auth.GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
      }
      await _firebaseAuth.signInWithCredential(credential);
    } catch (_) {
      throw LogInWithGoogleFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await _firebaseAuth.signOut();
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, username: displayName);
  }
}
