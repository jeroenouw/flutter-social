import 'package:flutter/material.dart';
import 'package:social/src/models/edition_model.dart';

import '../app.dart';

class SettingsScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Settings')),
        body: SettingsScreenContent(),
    );
  }
}

class SettingsScreenContent extends StatefulWidget {
  @override
  _SettingsScreenContentState createState() => _SettingsScreenContentState();
}

class _SettingsScreenContentState extends State<SettingsScreenContent> {
  bool _premiumEnabled;
  bool _darkModeEnabled = false;
  bool _cloudEnabled = false;
  
  @override
  Widget build(BuildContext context) {
    _premiumEnabled = _checkAndSetEdition();

    return ListView(
      children: [
        SwitchListTile(
          title: Text('Premium'),
          value: _premiumEnabled,
          onChanged: (bool value) {  
            _toggleEdition(value);
          },
          secondary: _premiumEnabled ? Icon(Icons.star) : Icon(Icons.star_border),
        ),
       SwitchListTile(
          title: Text('Darkmode (Soon available)'),
          value: _darkModeEnabled,
          onChanged: (bool value) {  
            setState(() { 
              _darkModeEnabled = value; 
            });
          },
          secondary: _darkModeEnabled ? Icon(Icons.brightness_2) : Icon(Icons.brightness_5),
        ),
        SwitchListTile(
          title: Text('Cloud (Soon available)'),
          value: _cloudEnabled,
          onChanged: (bool value) {  
            setState(() { 
              _cloudEnabled = value; 
            });
          },
          secondary: _cloudEnabled ? Icon(Icons.cloud_done) : Icon(Icons.cloud_queue),
        ),
      ],
    );
  }

  bool _checkAndSetEdition() {
    if (SocialApp.isFreeEdition) {
      return false;
    } else {
      return true;
    }
  }

  void _toggleEdition(value) {
    setState(() { 
      _premiumEnabled = value; 
    });
    if (SocialApp.isFreeEdition) {
      SocialApp.edition = Edition.premium;
    } else {      
      SocialApp.edition = Edition.free;
    }
  }
}