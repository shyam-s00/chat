import 'package:chat/shared/presentation/TextStyles.dart';
import 'package:flutter/material.dart';
import 'package:chat/models/Message.dart';//Todo: rename file name
import 'package:intl/intl.dart';

class MessageWidget extends StatelessWidget {

  final Message model;
  final int index;
  final GestureTapCallback onTap;
  final GestureLongPressCallback onLongPressed;
  final DismissDirectionCallback onDismissed;

  MessageWidget(this.model, this.index, this.onTap, this.onLongPressed, this.onDismissed);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(model.msgId),
      background: Container(color: Theme.of(context).backgroundColor),
      direction: DismissDirection.endToStart,
      onDismissed: onDismissed,
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
        elevation: 4.0,
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListTile(
            leading: Container(
              child: CircleAvatar(
                child: model.isSelected
                    ? Icon(Icons.check)
                    : Text(model.avatar, style: TextStyles.appBarHeadingBold2)
              ),
            ),
            title: Row(
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: Text(model.ownerId, style: TextStyles.appBarHeadingBold3)
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 4.0),
                        child: Text(model.msgBody, style: TextStyles.appBarHeading4)
                      )
                    ],
                  ),
                )
              ],
            ),
            trailing: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              verticalDirection: VerticalDirection.down,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Text(DateFormat('Hms').format(model.sentDate))
              ],
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 2.0),
            onLongPress: onLongPressed,
            onTap: onTap,
            dense: true,
          ),
        ),
      ),
    );
  }
}