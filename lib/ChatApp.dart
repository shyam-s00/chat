import 'package:chat/screens/HomeScreen.dart';
import 'package:flutter/material.dart';

class ChatApp extends StatelessWidget
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      key: new Key('app'),
      title: 'Chat',
      home: new HomeScreen(),
//      initialRoute: '/',
//      routes: <String, WidgetBuilder> {
//        '/' : (context) => new LoginScreen(),
//      },
    );
  }

}