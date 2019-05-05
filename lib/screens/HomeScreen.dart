import 'package:chat/models/User.dart';
import 'package:chat/screens/ChatScreen.dart';
import 'package:chat/screens/LoginScreen.dart';
import 'package:chat/shared/services/CloudStore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new HomeScreenState();

  final CloudStore authService = new CloudStore();
}

class HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    return new StreamBuilder<User>(
      stream: widget.authService.onAuthStateChanged(),
      builder: (context, snapshot)  {
        if (snapshot.connectionState != ConnectionState.waiting && snapshot.hasData) {
          return ChatScreen(snapshot.data);
        }
        else {
          return LoginScreen();
        }
      },
    );
  }
}