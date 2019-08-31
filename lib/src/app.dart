import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterSocialApp',
      theme: ThemeData(
        primaryColor: Colors.greenAccent,
      ),
      home: MainPage(),
      showPerformanceOverlay: false,
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  PageController _pageController;

  /// Indicating the current displayed page (0: trends, 1: feed, 2: community)
  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Container(color: Colors.greenAccent),
          Container(color: Colors.blueAccent),
          Container(color: Colors.redAccent),
        ],
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add), 
            title: Text('trends')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on), 
            title: Text('feed')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people), 
            title: Text('community')
          )
        ],
        onTap: onTap,
        currentIndex: _pageIndex
      ),
    );
  }

  void onTap(int pageIndex) {
    _pageController.animateToPage(
      pageIndex,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void onPageChanged(int pageIndex) {
    setState(() {
      this._pageIndex = pageIndex;
    });
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
}