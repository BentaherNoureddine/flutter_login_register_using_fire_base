

import 'package:dartz/dartz.dart';

import '../../../../core/failure/failures.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';

class RegisterUserUseCase{
  final UserRepository userRepository;

  RegisterUserUseCase(this.userRepository);

  Future<Either<Failure,Unit>> call(UserEntity user) async{
    return await userRepository.registerUser(user);
  }

}