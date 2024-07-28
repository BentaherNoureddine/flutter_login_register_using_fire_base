import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/failure/auth_failures.dart';
import '../../../../../core/failure/failures.dart';
import '../../../../../core/strings/failures.dart';
import '../../../domain/entities/user_entity.dart';
import '../../../domain/usecases/register_user.dart';

part 'user_manager_event.dart';
part 'user_manager_state.dart';

class UserManagerBloc extends Bloc<UserManagerEvent, UserManagerState> {
  final RegisterUserUseCase registerUserUseCase;
  UserManagerBloc({required this.registerUserUseCase})
      : super(UserManagerInitial()) {
    on<UserManagerEvent>((event, emit) async {
      print('register 1');
      if (event is RegisterEvent) {
        emit(RegisteringUserState());
        final failureOrDoneRegister = await registerUserUseCase(event.user);

        failureOrDoneRegister.fold(
                (left) => emit(RegisterUserErrorState(
                message: _mapRegisterFailureToMessage(left))),
                (_) => emit(RegisteredUserState()));
      }
    });
  }

  String _mapRegisterFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case OfflineFailure:
        return OFFLINE_FAILURE_MESSAGE;
      case RegisterUserWeakPwdFailure:
        return REGISTER_USER_WEAK_PWD;
      case RegisterUserUsedEmailFailure:
        return REGISTER_USER_EMAIL_USED;
      default:
        return "Erreur inconnue...";
    }
  }

/**TODO update user bloc */
}
