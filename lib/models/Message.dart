import 'package:uuid/uuid.dart';

class Message {
  bool isSelected;
  String msgBody;
  String ownerId;
  String msgId;
  String avatar;
  DateTime sentDate;

  Message(this.ownerId,
      {this.msgBody = '',
      this.isSelected = false,
      this.avatar,
      this.sentDate,
      String id})
      : this.msgId = id ?? new Uuid().v1();

  @override
  String toString() =>
      'Message -> {id: $msgId, sender: $ownerId, body: $msgBody, avatar: $avatar, sent on: $sentDate}';

  @override
  int get hashCode =>
      msgId.hashCode ^
      ownerId.hashCode ^
      msgBody.hashCode ^
      avatar.hashCode ^
      sentDate.hashCode;

  @override
  bool operator ==(other) =>
      identical(other, this) ||
      other is Message &&
          msgId == other.msgId &&
          ownerId == other.ownerId &&
          msgBody == other.msgBody &&
          avatar == other.avatar &&
          sentDate == other.sentDate &&
          runtimeType == other.runtimeType;

  Map<String, dynamic> toJson() => {
        "id": msgId,
        "owner": ownerId,
        "body": msgBody,
        "avatar": avatar,
        "sentDate": sentDate.toString(),
        "isSelected": isSelected
      };

  // factory methods
  static Message create(String owner, String msg, {DateTime sentDate, String avatar = ''}) {
    var avatarText =  avatar.isEmpty ? owner.substring(0, 1) : avatar;
    return new Message(owner, msgBody: msg, sentDate: sentDate ?? DateTime.now(), avatar: avatarText);
  }
}
