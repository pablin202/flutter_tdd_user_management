import 'package:dartz/dartz.dart';
import 'package:tdd_flutter_sample/core/errors/exceptions.dart';
import 'package:tdd_flutter_sample/core/errors/failure.dart';
import 'package:tdd_flutter_sample/core/utils/typedef.dart';
import 'package:tdd_flutter_sample/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/entities/user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/repositories/authentication_repository.dart';

class AuthenticationRepositoryImpl extends AuthenticationRepository {
  final AuthenticationRemoteDataSource _dataSource;

  AuthenticationRepositoryImpl(this._dataSource);

  @override
  ResultVoid createUser(
      {required String createdAt,
      required String name,
      required String avatar}) async {
    try {
      await _dataSource.createUser(
          createdAt: createdAt, name: name, avatar: avatar);
      return const Right(null);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }

  @override
  ResultFuture<List<User>> getUsers() async {
    try {
      final result = await _dataSource.getUsers();
      final list = result.map((e) => User(
          id: e.id,
          createdAt: e.createdAt,
          name: e.name,
          avatar: e.avatar)).toList();
      return Right(list);
    } on ApiException catch (e) {
      return Left(ApiFailure.fromException(e));
    }
  }
}
