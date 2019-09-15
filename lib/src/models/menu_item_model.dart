import 'package:flutter/material.dart';

import '../widgets/custom_alert.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final Widget screen;

  MenuItem({@required this.title, @required this.icon, @required this.screen});
}

List<MenuItem> menuItems = <MenuItem>[
  MenuItem(title: 'TBA', icon: Icons.notifications, screen: CustomAlert(
    title: 'Nothing to see here', 
    content: 'This page is still in development'
  )),
];
