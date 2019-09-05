import 'package:flutter/material.dart';
import 'package:social/src/mocks/chat_overview_mock_data.dart';
import 'package:social/src/screens/chat_detail_screen.dart';

class ChatOverviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: chatOverviewMockData.length,
        itemBuilder: (context, int i) => Column(
          children: <Widget>[
            Divider(
              height: 10.0,
            ),
            ChatOverviewScreenContent(index: i),
          ],
        ),
      )
    );
  }
}

class ChatOverviewScreenContent extends StatefulWidget {
  final int index;

  @override
  _ChatOverviewScreenState createState() => _ChatOverviewScreenState();

  ChatOverviewScreenContent({this.index});
}

class _ChatOverviewScreenState extends State<ChatOverviewScreenContent> {

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey,
        child: CircleAvatar(child: Text(chatOverviewMockData[widget.index].name[0])),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            chatOverviewMockData[widget.index].name,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            chatOverviewMockData[widget.index].time,
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
        ],
      ),
      subtitle: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            chatOverviewMockData[widget.index].message,
            style: TextStyle(color: Colors.grey, fontSize: 15.0),
          ),
          Icon(
            Icons.check,
            color: Colors.grey,
          ),
        ],
      ),
      onTap: () => _goToChat(chatOverviewMockData[widget.index].name)
    );
  }

  void _goToChat(String name) {
    Navigator.push(context, MaterialPageRoute<void>(builder: (BuildContext context) => ChatDetailScreen(userToChat: name)));
  }
}
