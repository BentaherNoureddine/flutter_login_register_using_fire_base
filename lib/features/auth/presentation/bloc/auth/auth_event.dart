part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}



class LoginEvent extends AuthEvent {
  final UserEntity user;

  LoginEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class LogoutEvent extends AuthEvent {
}
