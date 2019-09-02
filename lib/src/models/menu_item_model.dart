import 'package:flutter/material.dart';
import 'package:social/src/screens/profile_screen.dart';
import 'package:social/src/screens/settings_screen.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final Widget screen;

  MenuItem({this.title, this.icon, this.screen});
}

List<MenuItem> menuItems = <MenuItem>[
  MenuItem(title: 'Profile', icon: Icons.person, screen: ProfileScreen()),
  MenuItem(title: 'Settings', icon: Icons.settings, screen: SettingsScreen()),
];
