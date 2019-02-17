import 'package:flutter/material.dart';

class SendTextWidget extends StatelessWidget {

  final TextEditingController sendTextController;
  final VoidCallback onPressed;

  SendTextWidget({this.sendTextController, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              keyboardType: TextInputType.multiline,
              controller: sendTextController,
              decoration: InputDecoration.collapsed(hintText: 'Enter text here'),
            ),
          ),
          Material(
            elevation: 6.0,
            type: MaterialType.transparency,
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(side: BorderSide(style: BorderStyle.none)),
            child: IconButton(
                icon: Icon(Icons.send),
                onPressed: onPressed
            ),
          )
        ],
      ),
    );
  }
}