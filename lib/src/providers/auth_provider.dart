import 'dart:async';
import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/auth_model.dart';
import '../models/http_exception_model.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  AuthMode _authMode;

  String _userDataKey = 'userData';

  bool get isAuth => token != null;
  String get userId => _userId;
  String get token => _expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null 
    ? _token 
    : null;

  /// Signup user based on [email] and [password] and makes use of [_authenticate()] method.
  Future<void> signup(String email, String password) async {
    _authMode = AuthMode.Signup;
    return _authenticate(email, password, 'signupNewUser', _authMode);
  }

  /// Login user based on [email] and [password] and makes use of [_authenticate()] method.
  Future<void> login(String email, String password) async {
    _authMode = AuthMode.Login;
    return _authenticate(email, password, 'verifyPassword', _authMode);
  }

  /// Does login automatically if user has still a session.
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

  /// Logout user and sets the following class properties to null: 
  /// [_token], [_userId], [_expiryDate] and [_authTimer].
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

  /// Authenticates user based on [email] and [password]. 
  /// 
  /// Needs [urlSegment] for API call and [authMode] for set/get current user.
  /// Throws [HttpException] with [error] and [message] if API call goes wrong.
  Future<void> _authenticate(String email, String password, String urlSegment, AuthMode authMode) async {
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
        throw HttpException(message: responseData['error']['message']);
      }

      _setUserSession(responseData);

      if (authMode == AuthMode.Signup) {
        await _setNewUser(email); 
      } else if (authMode == AuthMode.Login) {
        await _getCurrentUser();
        _autoLogoutAfterExpiryDate();
        await _saveUserSessionOnDevice();
      }

      notifyListeners();
    } on Exception catch (error) {
      throw error;
    }
  }

  /// Set a user session by setting the class properties: [_token], [_userId] and [_expiryDate].
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

  /// Set a new user to the database via the [UserProvider] class. 
  /// Takes class properties: [_userId] and [_token]. Has [email] argument.
  Future _setNewUser(String email) async {
    User newUser = User(
      userId: _userId,
      email: email,
      displayName: '',
      bio: '',
    );
    
    await UserProvider(_token).setUser(newUser);
  }

  /// Get the current user from the database via the [UserProvider] class.
  /// Takes class properties: [_userId] and [_token]. 
  Future _getCurrentUser() async {
    await UserProvider(_token).getCurrentUser(_userId);
  }

  /// Set a user session on mobile device based on class properties: [_token], [_userId] and [_expiryDate].
  Future _saveUserSessionOnDevice() async {
    final preferences = await SharedPreferences.getInstance();
    final userDataJSON = json.encode({'token': _token, 'userId': _userId, 'expiryDate': _expiryDate.toIso8601String()});
    preferences.setString(_userDataKey, userDataJSON);
  }

  /// Does logout automatically after [_expiryDate] is over
  void _autoLogoutAfterExpiryDate() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }
}
