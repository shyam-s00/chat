import 'package:chat/models/Message.dart';
import 'package:chat/models/User.dart';
import 'package:chat/screens/maindrawerscreen.dart';
import 'package:chat/shared/presentation/TextStyles.dart';
import 'package:chat/shared/services/CloudStore.dart';
import 'package:chat/widgets/MessageWidget.dart';
import 'package:chat/widgets/sendtextwidget.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new ChatScreenState();

  final User user;

  ChatScreen(this.user);
}

class ChatScreenState extends State<ChatScreen> {

  List<Message> messages = new List<Message>();
  CloudStore client = new CloudStore();
  final TextEditingController _sendTextController = new TextEditingController();

  @override
  void initState() {
    client.getAllMessages().listen(onNext);
    super.initState();
  }
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
      drawer: MainDrawerScreen(displayName: widget.user.displayName, emailId: widget.user.email),
      body: _buildChatScreen(),
    );
  }

  Widget _buildChatScreen() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              padding: EdgeInsets.all(8.0),
              itemBuilder: (_, int index) {
                var model = messages[index];
                return MessageWidget(model, index, () => _selectMessage(model), () => _deleteOnPressed(index), (__) => _deleteOnDismiss(model.msgId));
              },
              reverse: true,
              itemCount: messages.length,
            )
          ),
          Divider(
            height: 1.0,
          ),
          Container(
            decoration: BoxDecoration(color: Theme.of(context).cardColor),
            child: SendTextWidget(sendTextController: _sendTextController, onPressed: () => _onSubmitted(_sendTextController.text)),
          )
        ],
      )
    );
  }

  void _onSubmitted(String text) {
    _sendTextController.clear();

    String owner = widget.user.displayName ?? widget.user.email;
    Message msg = Message.create(owner, text, sentDate: DateTime.now());
    if (msg != null) {
      setState(() {
        messages.insert(0, msg);
      });
    }
  }

  void _selectMessage(Message message) {
    if (message != null) {
      setState(() {
        message.isSelected ? message.isSelected = false : message.isSelected = true;
      });
    }
  }

  void _deleteOnPressed(int index) {
    setState(() {
      messages.removeAt(index);
    });
  }

  void _deleteOnDismiss(String msgId) {
    setState(() {
      messages.removeWhere((Message m) => m.msgId == msgId);
    });
  }


  void onNext(List<Message> event) {
    setState(() {
      messages.clear();
      messages.addAll(event);
    });

  }
}