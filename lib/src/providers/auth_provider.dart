import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:social/src/models/http_exception_model.dart';
import 'package:social/src/providers/user_provider.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  String _userDataKey = 'userData';

  bool get isAuth {
    return token != null;
  }

  String get userId {
    return _userId;
  }

  String get token {
    if (_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null) {
      return _token;
    }
    return null;
  }

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final String apiKey = 'AIzaSyAqFX4jaTxB8e0d5QqgNAUDCPGUCdaa3pU';
    final String url ='https://www.googleapis.com/identitytoolkit/v3/relyingparty/$urlSegment?key=$apiKey';
    
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }

      _setUserSession(responseData);
      _autoLogoutAfterExpiryDate();
      notifyListeners();
      await _saveUserSessionOnDevice();
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }

  Future<bool> autoLoginIfUserSession() async {
    final preferences = await SharedPreferences.getInstance();
    if (!preferences.containsKey(_userDataKey)) {
      return false;
    }
    final extractedUserData = json.decode(preferences.getString(_userDataKey)) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogoutAfterExpiryDate();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    notifyListeners();

    final preferences = await SharedPreferences.getInstance();
    preferences.remove(_userDataKey);
  }

  void _setUserSession(responseData) {
    _token = responseData['idToken'];
    _userId = responseData['localId'];
    _expiryDate = DateTime.now().add(
      Duration(
        seconds: int.parse(
          responseData['expiresIn']
        )
      )
    );
  }

  Future _saveUserSessionOnDevice() async {
    final preferences = await SharedPreferences.getInstance();
    final userDataJSON = json.encode({'token': _token, 'userId': _userId, 'expiryDate': _expiryDate.toIso8601String()});
    preferences.setString(_userDataKey, userDataJSON);
  }

  void _autoLogoutAfterExpiryDate() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
