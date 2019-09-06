import 'package:flutter/material.dart';
import 'package:social/src/models/menu_item_model.dart';
import 'package:social/src/screens/chat_overview_screen.dart';
import 'package:social/src/widgets/app_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  MenuItem _selectedMenuItem = menuItems[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Social App'),
        actions: <Widget>[
          PopupMenuButton<MenuItem>(
            onSelected: _selectMenuItem,
            itemBuilder: (BuildContext context) {
              return menuItems.map((MenuItem menuItem) {
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

  @override 
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override 
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _selectMenuItem(MenuItem menuItem) {
    setState(() {
      this._selectedMenuItem = menuItem;
    });

    Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => menuItem.screen));
  }
}
