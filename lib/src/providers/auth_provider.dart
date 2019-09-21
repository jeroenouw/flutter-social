import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthorized = false;

  bool get isAuth => _isAuthorized == true && getUserFromDevice() != null;

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

      User user = await getUserFromDatabase(result.user.uid);
      await _setUserOnDevice(user);
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

      await _removeUserFromDevice();
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

  static Future<User> getUserFromDatabase(String userId) async {
    if (userId != null) {
      return Firestore.instance
          .collection('users')
          .document(userId)
          .get()
          .then((documentSnapshot) => User.fromDocument(documentSnapshot));
    } else {
      return null;
    }
  }

  static void setUserToDatabase(User user) async {
    _checkIfUserExist(user.userId).then((userExists) {
      if (!userExists) {
        Firestore.instance
            .document('users/${user.userId}')
            .setData(user.toJson());
      } else {
      }
    });
  }

  static Future<User> getUserFromDevice() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user') != null) {
      User user = userFromJson(preferences.getString('user'));
      print('GETUSER: $user');
      return user;
    } else {
      return null;
    }
  }

  static Future<void> _setUserOnDevice(User user) async {
    final preferences = await SharedPreferences.getInstance();
    final userDate = userToJson(user);
      print('SETUSER: $userDate');
    await preferences.setString('user', userDate);
  }
  
  Future<void> _removeUserFromDevice() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static Future<bool> _checkIfUserExist(String userId) async {
    bool exists = false;
    try {
      await Firestore.instance.document('users/$userId').get().then((doc) {
        if (doc.exists)
          exists = true;
        else
          exists = false;
      });
      return exists;
    } on Exception catch (error) {
      throw error;
    }
  }
}
