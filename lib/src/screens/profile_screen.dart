import 'package:flutter/material.dart';

import '../providers/user_provider.dart';
import '../models/user_model.dart';
import '../mocks/user_mock_data.dart';
import '../app.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: ProfileScreenContent()
    );
  }
}

class ProfileScreenContent extends StatefulWidget {
  @override
  _ProfileScreenContentState createState() => _ProfileScreenContentState();
}

class _ProfileScreenContentState extends State<ProfileScreenContent> {
  User _currentUser = userMock;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _setUserState();

    Widget titleSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    _currentUser.displayName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (SocialApp.isPremiumEdition) 
                  Text(
                    'Premium user',
                  ),
                Text(
                  _currentUser.email,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
                Text(
                  _currentUser.userId,
                  style: TextStyle(
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildButtonColumn(color, Icons.message, 'Message'),
          _buildButtonColumn(color, Icons.call, 'Call'),
          _buildButtonColumn(color, Icons.share, 'Share'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        _currentUser.bio,
        softWrap: true,
      ),
    );

    return ListView(
      children: [
        Image.asset(
          'images/profile.jpg',
          width: 600,
          height: 240,
          fit: BoxFit.cover,
        ),
        titleSection,
        buttonSection,
        textSection,
      ],
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(icon),
          tooltip: label,
          color: color,
          padding: const EdgeInsets.only(top: 8),
          onPressed: () => print('Button pressed'),
        )
      ],
    );
  }

  void _setUserState() async {
    User user = await UserProvider.getUserFromDevice();
    setState(() {
      _currentUser = user;
    });
  }
}
