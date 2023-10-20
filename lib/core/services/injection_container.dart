import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:tdd_flutter_sample/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_flutter_sample/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_flutter_sample/src/authentication/presentation/cubit/authentication_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    ..registerFactory(
        () => AuthenticationCubit(createUser: sl(), getUsers: sl()))
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImpl(sl()))
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImpl(sl()))
    ..registerLazySingleton(http.Client.new);
}
