import 'package:chat/screens/LoginScreen.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      key: new Key('app'),
      title: 'Chat',      
      initialRoute: '/',
      routes: {
        '/' : (context) => new LoginScreen(),
      },
    );
  }

}