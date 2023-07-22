import 'package:auction_bd24/themes/app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginController extends GetxController {
  final loginEmailController = TextEditingController();
  final loginPassController = TextEditingController();
  var logprf;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  UserCredential? _userCredential;
  UserCredential getUserCredential() => _userCredential!;

  RxBool emailAlreadyUsed = false.obs;

  Future<bool> checkLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }

  googleSign() async {
    final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleSignInAccount?.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    if (googleSignInAccount != null) {
      Get.offNamed('landing');
    }
    _userCredential = await _auth.signInWithCredential(credential);
    _fireStore.collection('users').doc(_userCredential?.user?.uid).set({
      "id": _userCredential?.user?.uid,
      "name": _userCredential?.user?.displayName,
      'email': _userCredential?.user?.email,
      "photo": _userCredential?.user?.photoURL
    });
  }

  createNewUser(email, pass) async {
    try {
      await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      Get.offNamed('/login');
    } catch (signUpException) {
      if (signUpException is FirebaseAuthException) {
        if (signUpException.code == 'email-already-in-use') {
          Get.snackbar('error', 'this email is already in use',
              snackPosition: SnackPosition.TOP);
        }
      }
    }
  }

  loginWithEmail(email, pass) async {
    try {
      UserCredential user =
          await _auth.signInWithEmailAndPassword(email: email, password: pass);
      final data = {
        'id': user.user!.uid,
        'name': '',
        'email': user.user!.email,
        'photo': ''
      };
      _fireStore.collection('users').doc(user.user!.uid).set(data);
      if (email == user.user!.email) {
        Get.toNamed('/landing');
      }
    } catch (signInException) {
      if (signInException is FirebaseAuthException) {
        if (signInException.code == 'invalid-email') {
          Get.snackbar('Auth Error', 'there is no account for this email',
              snackPosition: SnackPosition.TOP,
              colorText: AppTheme.appColor.loginSnackError);
        }
        if (signInException.code == 'wrong-password') {
          Get.snackbar('Auth Error', 'Password is invalid',
              snackPosition: SnackPosition.TOP,
              colorText: AppTheme.appColor.loginSnackError);
        }
      }
    }
  }

  googleSignout() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
    Get.offNamed('/login');
  }
}
