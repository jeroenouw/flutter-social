import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:provider/provider.dart';

import '../constants/routing_contant.dart';
import '../providers/auth_provider.dart';
import './custom_alert.dart';
import '../app.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Navigation'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () {
              Navigator.of(context).pushNamed(profileRoute);
            },
          ),
          ListTile(
            leading: Icon(Icons.phonelink_setup),
            title: Text('Settings'),
            onTap: () {
              Navigator.of(context).pushNamed(settingsRoute);
            },
          ),  
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              Navigator.of(context).pushNamed(notificationRoute);
            },
          ),
          if (SocialApp.isPremiumEdition) 
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Premium content'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => 
                  CustomAlert(
                    title: 'Nothing to see here', 
                    content: 'This page is still in development'
                  )
                ));
              },
            ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamedAndRemoveUntil(authRoute, (Route<dynamic> route) => false);
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Share'),
            onTap: () {
              FlutterShareMe().shareToSystem(
                msg: 'Flutter Social - Everything in one app',
              );
            },
          ),
        ],
      ),
    );
  }
}
