import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
  @override
  Widget build(BuildContext context) {
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
                    'Jeroen Ouwehand',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Software Engineer',
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
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec condimentum odio ut dictum molestie. Nullam in metus metus.' 
        'Aliquam erat volutpat. Fusce gravida mollis velit ornare luctus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; '
        'Nullam sed nulla lobortis, molestie odio non, molestie sem.'
        'Aliquam sodales scelerisque mi, blandit dapibus arcu vulputate congue. Morbi lacinia quis risus at cursus.'
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec condimentum odio ut dictum molestie. Nullam in metus metus.' 
        'Aliquam erat volutpat. Fusce gravida mollis velit ornare luctus. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; ',
        softWrap: true,
      ),
    );

    return Scaffold(
        appBar: AppBar(title: Text('Profile')),
        body: ListView(
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
        ),
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
}
