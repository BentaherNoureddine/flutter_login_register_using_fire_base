import 'package:dartz/dartz.dart';
import 'package:forest_reporter/core/failure/failures.dart';

import '../entities/user_entity.dart';

abstract class UserRepository{



  Future<Either<Failure,Unit>> registerUser(UserEntity user);
  Future<Either<Failure,Unit>> updateUser(UserEntity user);

  Future<Either<Failure,Unit>> signIn(UserEntity user);
  Future<Either<Failure,Unit>> signOut();
}
