

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/failure/auth_failures.dart';
import '../../../../core/failure/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user_data_source.dart';
import '../models/user_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  final NetwortkInfo networkInfo;

  UserRepositoryImpl({required this.userDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, Unit>> registerUser(UserEntity user) async {
    UserModel userModel = UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        profileURL: user.profilURL,
        password: user.password);

    if (await networkInfo.isConnected) {
      try {
        final credential = await userDataSource.registerUser(userModel);
        return Right(unit);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          return Left(RegisterUserWeakPwdFailure());
        } else if (e.code == 'email-already-in-use') {
          return Left(RegisterUserUsedEmailFailure());
        } else {
          return Left(RegisterUserFailure());
        }
      } catch (e) {
        return Left(RegisterUserFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signIn(UserEntity user) async {
    UserModel userModel = UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        profileURL: user.profilURL,
        password: user.password);

    if (await networkInfo.isConnected) {
      try {
        final credential = await userDataSource.signInUser(userModel);
        return Right(unit);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          return Left(SignInUserNotFoundFailure());
        } else if (e.code == 'wrong-password') {
          return Left(SignInWrongPwdFailure());
        } else {
          return Left(SignInFailure());
        }
      } catch (e) {
        return Left(SignInFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> signOut() async {
    if (await networkInfo.isConnected) {
      await FirebaseAuth.instance.signOut();
      print("signoout");
      return Right(unit);
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(UserEntity user) async {
    UserModel userModel = UserModel(
        uid: user.uid,
        name: user.name,
        email: user.email,
        profileURL: user.profilURL,
        password: user.password);
    if (await networkInfo.isConnected) {
      await FirebaseAuth.instance.currentUser
          ?.updateDisplayName(userModel.name);
      await FirebaseAuth.instance.currentUser?.updateEmail(userModel.email);
      await FirebaseAuth.instance.currentUser
          ?.updatePhotoURL(userModel.profilURL);
      return Right(unit);
    } else {
      return Left(OfflineFailure());
    }
  }
}
