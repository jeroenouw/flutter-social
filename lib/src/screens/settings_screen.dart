import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Settings')),
        // body: SettingsScreenContent()
    );
  }
}

// FIXME: 
// class SettingsScreenContent extends StatefulWidget {
//   @override
//   _SettingsScreenContentState createState() => _SettingsScreenContentState();
// }

// class _SettingsScreenContentState extends State<SettingsScreenContent> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text('Settings')),
//     );
//   }
// }
