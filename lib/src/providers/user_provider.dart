import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/user_model.dart';

class UserProvider {

  static Future<User> getUserFromDatabase(String userId) async {
    if (userId.isNotEmpty) {
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
        return null;
      }
    });
  }

  static void updateUserInDatabase(User user) async {
    Firestore.instance
      .document('users/${user.userId}')
      .updateData(user.toJson());
  }

  static Future<User> getUserFromDevice() async {
    final preferences = await SharedPreferences.getInstance();
    if (preferences.getString('user').isNotEmpty) {
      User user = userFromJson(preferences.getString('user'));
      return user;
    } else {
      return null;
    }
  }

  static Future<void> setUserOnDevice(User user) async {
    final preferences = await SharedPreferences.getInstance();
    final userDate = userToJson(user);
    await preferences.setString('user', userDate);
  }
  
  static Future<void> removeUserFromDevice() async {
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
