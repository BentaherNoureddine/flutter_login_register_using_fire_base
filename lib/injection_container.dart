import 'package:get_it/get_it.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/firebase/firebase_service.dart';
import 'core/network/network_info.dart';
import 'features/auth/data/datasource/user_data_source.dart';
import 'features/auth/data/repositories/user_repository_impl.dart';
import 'features/auth/domain/repositories/user_repository.dart';
import 'features/auth/domain/usecases/register_user.dart';
import 'features/auth/domain/usecases/sign_in_user.dart';
import 'features/auth/domain/usecases/sign_out_user.dart';
import 'features/auth/presentation/bloc/auth/auth_bloc.dart';

import 'features/auth/presentation/bloc/user_manager/user_manager_bloc.dart';
import 'navigation/app_router.dart';

final sl = GetIt.instance;

Future<void> init() async {
//! Features - posts

// Bloc

  sl.registerLazySingleton(() => AuthBloc(
    signInUserUseCase: sl(),
    signOutUserUseCase: sl(),
  ));

  sl.registerLazySingleton(() => UserManagerBloc(registerUserUseCase: sl()));

// Usecases

  sl.registerLazySingleton(() => RegisterUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUserUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUserUseCase(sl()));

// Repository

  sl.registerLazySingleton<UserRepository>(
          () => UserRepositoryImpl(userDataSource: sl(), networkInfo: sl()));

// Datasources

  sl.registerLazySingleton<UserDataSource>(
          () => UserDataSourceImpl(firebaseService: sl()));

//! Core

  sl.registerLazySingleton<NetwortkInfo>(() => NetwortkInfoImpl(sl()));

//! External

  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker());

  //Firebase Service
  final firebaseService = await FirebaseService.init();
  sl.registerLazySingleton(() => firebaseService);

  //Router
  sl.registerLazySingleton(() => AppRouter(sl()));
}
