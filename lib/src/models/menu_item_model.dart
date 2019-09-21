import 'package:flutter/material.dart';

import '../screens/notification_screen.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final Widget screen;

  MenuItem({@required this.title, @required this.icon, @required this.screen});
}

List<MenuItem> menuItems = <MenuItem>[
  MenuItem(title: 'Notifications', icon: Icons.notifications, screen: NotificationScreen())
];
