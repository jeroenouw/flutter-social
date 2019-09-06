import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:social/src/models/user_model.dart';

// TODO: Implement UserProvider on ProfileScreen
class UserProvider with ChangeNotifier {
  final String authToken;
  User _currentUser;

  // FIXME:
  final String tempUserId = 'userId';

  UserProvider(this.authToken);

  User get currentUser {
    return _currentUser;
  }

  Future<void> getCurrentUser() async {
    final url = 'https://flutter-update.firebaseio.com/users/$tempUserId.json?auth=$authToken';
    
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
    } catch (error) {
      throw (error);
    }
  }

  Future<void> updateCurrentUser(User user) async {
    final url = 'https://flutter-update.firebaseio.com/users/$tempUserId.json?auth=$authToken';
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
    } catch (error) {
      throw (error);
    }
  }
}
