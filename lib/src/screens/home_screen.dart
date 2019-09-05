import 'package:flutter/material.dart';
import 'package:social/src/models/menu_item_model.dart';
import 'package:social/src/screens/auth_screen.dart';
import 'package:social/src/screens/chat_overview_screen.dart';
import 'package:social/src/widgets/custom_alert.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController _pageController;
  int _pageIndex = 0;
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
      body: PageView(
        children: <Widget>[
          ChatOverviewScreen(),
          CustomAlert(
            title: 'Nothing to see here', 
            content: 'This page is still in development'
          ),
          // FIXME:
          AuthScreen(),
        ],
        controller: _pageController,
        onPageChanged: _onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
           BottomNavigationBarItem(
            icon: Icon(Icons.people), 
            title: Text('Overview')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications), 
            title: Text('Notifications')
          ),
          // FIXME:
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add), 
            title: Text('Auth')
          ),
        ],
        onTap: _onTap,
        currentIndex: _pageIndex
      ),
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

  void _onTap(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onPageChanged(int pageIndex) {
    setState(() {
      this._pageIndex = pageIndex;
    });
  }
}