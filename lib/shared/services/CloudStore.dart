import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat/models/User.dart';
import 'dart:async';

class CloudStore {
  
  final FirebaseAuth _firebaseAuth;

  CloudStore() : this._firebaseAuth = FirebaseAuth.instance;

  Future<User> login(String userEmail, String pwd) async {
    return _firebaseAuth.signInWithEmailAndPassword(email: userEmail, password: pwd)
        .then((fb) => _mapToUser(fb));
  }
  
   User _mapToUser(FirebaseUser firebaseUser) {
    var user = new User(firebaseUser.uid, email: firebaseUser.email, avatarUrl: firebaseUser.photoUrl, displayName: firebaseUser.displayName);
    return user;
   }
}