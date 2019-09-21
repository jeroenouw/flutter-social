import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

User userFromJson(String string) {
  final jsonData = json.decode(string);
  return User.fromJson(jsonData);
}

String userToJson(User data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}

class User {
  final String userId;
  final String email;
  final String displayName;
  final String bio;

  User({@required this.userId, @required this.email, this.displayName, this.bio});

  factory User.fromJson(Map<String, dynamic> json) => User(
    userId: json['userId'],
    displayName: json['displayName'],
    email: json['email'],
    bio: json['bio'],
  );

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'displayName': displayName,
    'email': email,
    'bio': bio,
  };

  factory User.fromDocument(DocumentSnapshot doc) {
    return User.fromJson(doc.data);
  }
}
