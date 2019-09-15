import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'constants/routing_contant.dart';
import 'screens/home_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/chat_detail_screen.dart';
import 'screens/chat_overview_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/splash_screen.dart';
import 'providers/auth_provider.dart';

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
          // home: HomeScreen(), 
          home: auth.isAuth 
            ? HomeScreen() 
            : FutureBuilder(
              future: auth.autoLoginIfUserSession(), 
              builder: (context, authResultSnapshot) => 
                authResultSnapshot.connectionState == ConnectionState.waiting 
                ? SplashScreen()
                : AuthScreen()
          ),
          routes: <String, WidgetBuilder> {
            chatOverviewRoute: (BuildContext context) => ChatOverviewScreen(),
            chatDetailRoute: (BuildContext context) => ChatDetailScreen(),
            profileRoute: (BuildContext context) => ProfileScreen(),
            settingsRoute: (BuildContext context) => SettingsScreen(),
            authRoute: (BuildContext context) => AuthScreen(),
          },
          showPerformanceOverlay: false,
        ),
      ),
    );
  }
}
