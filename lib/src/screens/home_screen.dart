import 'package:flutter/material.dart';

import '../models/menu_item_model.dart';
import '../screens/chat_overview_screen.dart';
import '../widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social App'),
        actions: <Widget>[
          PopupMenuButton<MenuItem>(
            onSelected: _selectMenuItem,
            itemBuilder: (BuildContext context) {
              return menuItems.map<PopupMenuItem<MenuItem>>((MenuItem menuItem) {
                return PopupMenuItem<MenuItem>(
                  value: menuItem,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Icon(menuItem.icon),
                      Text(menuItem.title),
                    ],
                  ),
                );
              }).toList();
            },
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: ChatOverviewScreen(),
    );
  }

  void _selectMenuItem(MenuItem menuItem) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => menuItem.screen));
  }
}
