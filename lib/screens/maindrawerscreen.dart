import 'package:chat/shared/presentation/TextStyles.dart';
import 'package:flutter/material.dart';

class MainDrawerScreen extends StatelessWidget {

  final String displayName;
  final String emailId;

  MainDrawerScreen({this.displayName, this.emailId});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 8.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(displayName ?? '[NONE]'),
            accountEmail: Text(emailId),
            currentAccountPicture: Container(
              child: CircleAvatar(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                child: Text(_getAvatarText(), style: TextStyles.appBarHeadingBold1),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              ListTile(
                title: Text('Update Profile'),
                leading: Icon(Icons.update),
                contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                dense: true,
                onTap: () => Navigator.pop(context)
              ),
              ListTile(
                  title: Text('Update Email'),
                  leading: Icon(Icons.email),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  dense: true,
                  onTap: () => Navigator.pop(context)
              ),
              Divider(),
              ListTile(
                  title: Text('Share'),
                  leading: Icon(Icons.share),
                  contentPadding: EdgeInsets.symmetric(horizontal: 8.0),
                  dense: true,
                  onTap: () => Navigator.pop(context)
              )
            ],
          )
        ],
      ),
    );
  }

  String _getAvatarText() {
    String avatar =  displayName ?? emailId;
    return avatar.substring(0, 1).toUpperCase();
  }
}