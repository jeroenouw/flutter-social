import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/user_model.dart';

// TODO: Implement UserProvider on ProfileScreen
class UserProvider with ChangeNotifier {
  final String _authToken;
  final String _baseUrl = 'https://flutter-social-9fea3.firebaseio.com';
  User _currentUser;

  UserProvider(this._authToken);

  User get currentUser => _currentUser;

  /// Get the current user from the database.
  /// Takes [_authToken] class property and [_userId] argument. 
  Future<void> getCurrentUser(String userId) async {
    final url = '$_baseUrl/users/$userId.json?auth=$_authToken';
    
    try {
      final response = await http.get(url);
      
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      if (extractedData == null) {
        return;
      }
      User loadedUser = User(
            userId: extractedData['userId'],
            email: extractedData['email'],
            displayName: extractedData['displayName'],
            bio: extractedData['bio'],
      );

      _currentUser = loadedUser;

      notifyListeners(); 
    } on Exception catch (error) {
      throw (error);
    }
  }

  /// Set the user to the database.
  /// Takes [_authToken] class property and [user] object class as argument. 
  Future<void> setUser(User user) async {
    final url = '$_baseUrl/users/${user.userId}.json?auth=$_authToken';
    try {
      await http.post(
        url,
        body: json.encode({
          'userId': user.userId,
          'email': user.email,
          'displayName': user.displayName,
          'bio': user.bio,
        }),
      );
      notifyListeners();
    } on Exception catch (error) {
      throw (error);
    }
  }
}
