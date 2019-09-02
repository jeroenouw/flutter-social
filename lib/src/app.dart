import 'package:flutter/material.dart';
import 'package:social/src/screens/home_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterSocialApp',
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
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

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}