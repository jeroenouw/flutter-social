import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social/src/providers/auth_provider.dart';
import 'package:social/src/screens/auth_screen.dart';
import 'package:social/src/screens/home_screen.dart';
import 'package:social/src/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: AuthProvider(),
        ),
      ],
      child: Consumer<AuthProvider>(
        builder: (context, auth, _) => MaterialApp(
          title: 'FlutterSocialApp',
          theme: ThemeData(
            primaryColor: Colors.blueAccent,
          ),
          home: auth.isAuth 
            ? HomeScreen() 
            : FutureBuilder(
              future: auth.autoLoginIfUserSession(), 
              builder: (context, authResultSnapshot) => 
                authResultSnapshot.connectionState == ConnectionState.waiting 
                ? SplashScreen()
                : AuthScreen()
          ),
          showPerformanceOverlay: false,
        ),
      ),
    );
  }
}
