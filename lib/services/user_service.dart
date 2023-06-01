import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:protofac/models/user_model.dart';

import '../locator.dart';
import 'auth_service.dart';

class UserService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthService _auth = getIt<AuthService>();
  User? _user;
  UserModel? _userModel;

  Future<UserModel> getUserbyID(String id) async {
    return UserModel.fromDocumentSnapshot(
        await _firebaseFirestore.collection('Users').doc(id).get());
  }

  Future<UserModel> updateUserbyID(String id) async {
    return UserModel.fromDocumentSnapshot(
        await _firebaseFirestore.collection('users').doc(id).get());
  }

  void setUser(User user) {
    _user = user;
  }

  User? getUser() {
    return _user;
  }

  UserModel? getUserModel() {
    return _userModel;
  }

  void checkCreateUser(User user) async {
    var collectionReference = _firebaseFirestore.collection('users');
    var doc = await collectionReference.doc(user.uid).get();

    if (!doc.exists) {
      await collectionReference.doc(user.uid).set({
        'name': user.displayName,
        'email': user.email,
      });
    }
    setUser(user);
  }
}
