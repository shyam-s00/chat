import 'package:chat/models/Message.dart';
import 'package:chat/models/User.dart';
import 'package:chat/shared/presentation/TextStyles.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ChatScreenState();

  final User user;

  ChatScreen(this.user);
}

class ChatScreenState extends State<ChatScreen> {

  List<Message> messages = new List<Message>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text('Flutter Chat', style: TextStyles.appBarHeading1),
        elevation: 4.0,
        actions: <Widget>[
          PopupMenuButton(
            itemBuilder: (_) => <PopupMenuEntry>[
              PopupMenuItem(child: Text('Menu Item 1')),
              PopupMenuItem(child: Text('Menu Item 2')),
              PopupMenuDivider(),
              PopupMenuItem(child: Text('Yet another item'))
            ],
          )
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: <Widget>[
            UserAccountsDrawerHeader(
                accountName: Text('Dummy User'),
                accountEmail: Text('none@none.com')
            ),
            Column(
              children: <Widget>[
                Text('More items to come here')
              ],
            )
          ],
        ),
      ),

      body: _buildChatScreen(),
    );
  }

  Widget _buildChatScreen() {
    return Container(
      child: Text('Chat Message list comes here')
    );
  }
}