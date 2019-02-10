import 'dart:convert';
import 'dart:core';
import 'package:uuid/uuid.dart';

class User {
  String email;
  String displayName;
  Uuid id;
  String avatarUrl;

  User(id, {this.email, this.displayName, this.avatarUrl}) : this.id = id ?? Uuid().v1();

  @override
  String toString() => 'User: $displayName id: $id email: $email Avatar: $avatarUrl';

  @override
  int get hashCode => id.hashCode ^ email.hashCode ^ displayName.hashCode ^ avatarUrl.hashCode;

  @override
  bool operator ==(other) => identical(other, this) ||
      other is User &&
        other.id == this.id;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'email' : email,
        'displayName' : displayName,
        'avatarUrl' : avatarUrl
      };
  
  String toJsonString() => json.encode(this);

  fromJson(Map<String, dynamic> json)  {
    displayName = json['displayName'];
    email = json['email'];
    avatarUrl = json['avatarUrl'];
    id = Uuid().parse(json['id']) as Uuid;
  }
}