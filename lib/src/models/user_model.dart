import 'package:flutter/material.dart';

class User {
  final String userId;
  final String email;
  final String displayName;
  final String bio;

  User({@required this.userId, @required this.email, this.displayName, this.bio});
}
