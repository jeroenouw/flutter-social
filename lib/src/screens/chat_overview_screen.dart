import 'package:flutter/material.dart';
import 'package:social/src/mocks/chat_overview_mock_data.dart';
import 'package:social/src/screens/chat_detail_screen.dart';

class ChatOverviewScreen extends StatefulWidget {
  @override
  _ChatOverviewScreenState createState() => _ChatOverviewScreenState();
}

class _ChatOverviewScreenState extends State<ChatOverviewScreen> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: chatOverviewMockData.length,
      itemBuilder: (context, int i) => Column(
        children: <Widget>[
          Divider(
            height: 10.0,
          ),
          ListTile(
            leading: CircleAvatar(
              foregroundColor: Theme.of(context).primaryColor,
              backgroundColor: Colors.grey,
              child: CircleAvatar(child: Text(chatOverviewMockData[i].name[0])),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  chatOverviewMockData[i].name,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  chatOverviewMockData[i].time,
                  style: TextStyle(color: Colors.grey, fontSize: 14.0),
                ),
              ],
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  chatOverviewMockData[i].message,
                  style: TextStyle(color: Colors.grey, fontSize: 15.0),
                ),
                Icon(
                  Icons.check,
                  color: Colors.grey,
                ),
              ],
            ),
            onTap: () => _goToChat(chatOverviewMockData[i].name)
          )
        ],
      ),
    );
  }

  void _goToChat(String name) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => ChatDetailScreen(userToChat: name)));
  }
}
