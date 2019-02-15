import 'package:chat/models/Message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat/models/User.dart';
import 'dart:async';

class CloudStore {
  
  static const String path = 'dummy_msgs';
  
  final FirebaseAuth _firebaseAuth;
  final Firestore _firestore;

  CloudStore() : this._firebaseAuth = FirebaseAuth.instance, this._firestore = Firestore.instance;

  Future<User> login(String userEmail, String pwd) async {
    return _firebaseAuth.signInWithEmailAndPassword(email: userEmail, password: pwd)
        .then((fb) => _mapToUser(fb));
  }

  Stream<List<Message>> getAllMessages() {
    return _firestore.collection(path).snapshots().map(_convert);
  }

  List<Message> _convert(QuerySnapshot query) {
    return query.documents.map(_mapToMessage).toList();
  }
  
   User _mapToUser(FirebaseUser firebaseUser) {
    var user = new User(firebaseUser.uid, email: firebaseUser.email, avatarUrl: firebaseUser.photoUrl, displayName: firebaseUser.displayName);
    return user;
   }

   Message _mapToMessage(DocumentSnapshot document) {
    return new Message(
      document['owner'],
      id: document['id'],
      msgBody: document['body'],
      avatar: document['avatar'],
      isSelected: document['isSelected'],
      sentDate: DateTime.tryParse(document['sentDate'])
    );
   }
}