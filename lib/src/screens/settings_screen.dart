import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import '../service/connection_service.dart';
import '../constants/routing_contant.dart';
import '../models/edition_model.dart';
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
  bool _cloudEnabled = false;

  @override
  void initState() {
    super.initState();
    ConnectionService.init();
  }
  
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
          title: Text('Cloud (Soon available)'),
          value: _cloudEnabled,
          onChanged: (bool value) {  
            setState(() { 
              _cloudEnabled = value; 
            });
          },
          secondary: _cloudEnabled ? Icon(Icons.cloud_done) : Icon(Icons.cloud_queue),
        ),
        Divider(),
        ListTile(
          title: Text('You are currently connected to ${ConnectionService.onWifi ? 'WIFI' : 'mobile internet'} '),
        ),
        Divider(),
        ListTile(
          title: Text("To use darkmode, please toggle 'night option' on your device"),
        ),
        Divider(),
        if (SocialApp.isPremiumEdition) 
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Update profile (Premium)'),
            onTap: () {
              Navigator.of(context).pushNamed(updateProfileRoute);
            },
          ),
      ]
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