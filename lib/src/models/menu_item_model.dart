import 'package:flutter/material.dart';
import 'package:social/src/screens/profile_screen.dart';
import 'package:social/src/screens/settings_screen.dart';
import 'package:social/src/widgets/custom_alert.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final Widget screen;

  MenuItem({this.title, this.icon, this.screen});
}

List<MenuItem> menuItems = <MenuItem>[
  MenuItem(title: 'Profile', icon: Icons.person, screen: ProfileScreen()),
  MenuItem(title: 'Settings', icon: Icons.settings, screen: SettingsScreen()),
  MenuItem(title: 'TBA', icon: Icons.notifications, screen: CustomAlert(
    title: 'Nothing to see here', 
    content: 'This page is still in development'
  )),
];
