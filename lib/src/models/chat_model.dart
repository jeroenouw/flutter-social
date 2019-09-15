import 'package:flutter/material.dart';

class ChatModel {
  final int chatId;
  final String name;
  final String message;
  final String time;

  ChatModel({@required this.chatId, @required this.name, @required this.message, @required this.time});
}
