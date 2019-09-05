import 'package:flutter/material.dart';
import 'package:social/src/widgets/chat_message.dart';

class ChatDetailScreen extends StatefulWidget {
  final String userToChat;

  @override
  _ChatDetailScreenState createState() => _ChatDetailScreenState();

  ChatDetailScreen({this.userToChat});
}

class _ChatDetailScreenState extends State<ChatDetailScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = TextEditingController();

  bool _isComposing = false;
  String _userToChat = 'Default user';
  
  @override
  Widget build(BuildContext context) {
    _setUserToChat();

    return Scaffold(
      appBar: AppBar(title: Text(_userToChat)),
      body: Column( 
      children: <Widget>[                                         
        Flexible(                                             
          child: ListView.builder(                             
            padding: EdgeInsets.all(8.0),                     
            reverse: true,                                        
            itemBuilder: (_, int index) => _messages[index],      
            itemCount: _messages.length,                          
          ),
        ),
        Divider(height: 1.0),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor
          ),
          child: _buildChatMessage(),                      
        ),
      ],
      ),
    );
  }

  @override 
  void dispose() {
    for (ChatMessage message in _messages) {
      message.animationController.dispose();
    }
    super.dispose();
  }

  Widget _buildChatMessage() {
    return IconTheme(
      data: IconThemeData(color: Theme.of(context).accentColor),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          children: <Widget>[
            Flexible(
              child: TextField(
                controller: _textController,
                onChanged: (String messageContent) {
                  setState(() {
                    _isComposing = messageContent.length > 0;
                  });
                },
                onSubmitted: _sendChatMessge,
                decoration:
                    InputDecoration.collapsed(
                      enabled: true,
                      hintText: 'Enter your message...'),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 4.0),
              child: IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _isComposing ?
                    () => _sendChatMessge(_textController.text)
                    : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setUserToChat() {
    setState(() {
      this._userToChat = widget.userToChat;
    });
  }

  void _sendChatMessge(String messageContent) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      message: messageContent,
      animationController: AnimationController(
        duration: Duration(milliseconds: 400),
        vsync: this,
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
    message.animationController.forward();
  }
}
