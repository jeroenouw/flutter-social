import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/src/providers/auth_provider.dart';
import 'package:social/src/screens/auth_screen.dart';
import 'package:social/src/screens/chat_overview_screen.dart';
import 'package:social/src/widgets/custom_alert.dart';

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
          Divider(),
          ListTile(
            leading: Icon(Icons.people),
            title: Text('Overview'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => 
                ChatOverviewScreen()
              ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => 
                CustomAlert(
                  title: 'Nothing to see here', 
                  content: 'This page is still in development'
                )
              ));
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => 
                AuthScreen()
              ));
              Provider.of<AuthProvider>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
