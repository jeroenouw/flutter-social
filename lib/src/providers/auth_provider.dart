import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './user_provider.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthorized = false;

  bool get isAuth => _isAuthorized == true;

  Future<String> signup(String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
          
      notifyListeners();
      return result.user.uid;
    } on Exception catch (error) {
      throw error;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      AuthResult result = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User user = await UserProvider.getUserFromDatabase(result.user.uid);
      await UserProvider.setUserOnDevice(user);
      _isAuthorized = true;
      notifyListeners();
    } on Exception catch (error) {
      throw error;
    }
  }

   Future<void> logout() async {
    try {
       FirebaseAuth.instance.signOut();
      _isAuthorized = false;

      await UserProvider.removeUserFromDevice();
      notifyListeners();
    } on Exception catch (error) {
      throw error;
    }
  }

  Future<void> forgotPasswordEmail(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      notifyListeners();
    } on Exception catch (error) {
      throw error;
    }
  }


  Future<bool> autoLoginIfUserSession() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey('user')) {
      return false;
    }
    _isAuthorized = true;

    notifyListeners();
    return true;
  }
}
