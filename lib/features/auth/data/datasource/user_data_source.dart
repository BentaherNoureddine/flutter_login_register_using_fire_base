

import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/firebase/firebase_service.dart';
import '../models/user_model.dart';

abstract class UserDataSource {
  Future<UserCredential> registerUser(UserModel userModel);
  Future<UserCredential> signInUser(UserModel userModel);
  Future<void> signOutUser();
  Future<void>? updateUserName(String userName);
}

class UserDataSourceImpl implements UserDataSource {
  final FirebaseService firebaseService;

  UserDataSourceImpl({required this.firebaseService});
  @override
  Future<UserCredential> registerUser(UserModel userModel) {
    return firebaseService.getAuth().createUserWithEmailAndPassword(
        email: userModel.email!, password: userModel.password!);
  }

  @override
  Future<UserCredential> signInUser(UserModel userModel) {
    return firebaseService.getAuth().signInWithEmailAndPassword(
        email: userModel.email!, password: userModel.password!);
  }

  @override
  Future<void> signOutUser() {
    return firebaseService.getAuth().signOut();
  }

  @override
  Future<void>? updateUserName(String userName) {
    return firebaseService.getAuth().currentUser?.updateDisplayName(userName);
  }
}