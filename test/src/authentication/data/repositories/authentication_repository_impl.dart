import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter_sample/core/errors/exceptions.dart';
import 'package:tdd_flutter_sample/core/errors/failure.dart';
import 'package:tdd_flutter_sample/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_flutter_sample/src/authentication/data/repositories/authentication_repository_impl.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/entities/user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/repositories/authentication_repository.dart';

class MockAuthDataSource extends Mock
    implements AuthenticationRemoteDataSource {}

void main() {
  late AuthenticationRemoteDataSource dataSource;
  late AuthenticationRepository repository;

  setUp(() {
    dataSource = MockAuthDataSource();
    repository = AuthenticationRepositoryImpl(dataSource);
  });

  group('createUser', () {
    test(
        'should call the [RemoteDataSource.createUser] and complete successfully when the call is successful',
        () async {
      // Arrange
      when(() => dataSource.createUser(
              createdAt: any(named: 'createdAt'),
              name: any(named: 'name'),
              avatar: any(named: 'avatar')))
          .thenAnswer((_) async => Future.value());
      // Act
      final result = await repository.createUser(
          createdAt: fakeCreatedAt, name: fakeName, avatar: fakeAvatar);
      // Assert
      expect(result, equals(const Right(null)));

      verify(() => dataSource.createUser(
          createdAt: fakeCreatedAt,
          name: fakeName,
          avatar: fakeAvatar)).called(1);
      verifyNoMoreInteractions(dataSource);
    });

    test('should return a [ApiFailure] when the call is unsuccessful',
        () async {
      // Arrange
      when(() => dataSource.createUser(
          createdAt: any(named: 'createdAt'),
          name: any(named: 'name'),
          avatar: any(named: 'avatar'))).thenThrow(fakeApiException);

      // Act
      final result = await repository.createUser(
          createdAt: fakeCreatedAt, name: fakeName, avatar: fakeAvatar);

      // Assert
      expect(
          result,
          equals(Left(ApiFailure(
              statusCode: fakeApiException.statusCode,
              message: fakeApiException.message))));

      verify(() => dataSource.createUser(
          createdAt: fakeCreatedAt,
          name: fakeName,
          avatar: fakeAvatar)).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });

  group('getUsers', () {
    test(
        'should call the [RemoteDataSource.getUsers] and return [List<User>] when the call is successful',
        () async {
      // Arrange
      when(() => dataSource.getUsers()).thenAnswer((_) async => []);

      // Act
      final result = await repository.getUsers();

      // Assert
      expect(result, isA<Right<dynamic, List<User>>>());

      verify(() => dataSource.getUsers()).called(1);

      verifyNoMoreInteractions(dataSource);
    });

    test('should return a [ApiFailure] when the call is unsuccessful',
        () async {
      // Arrange
      when(() => dataSource.getUsers()).thenThrow(fakeApiException);

      // Act
      final result = await repository.getUsers();

      // Assert
      expect(
          result,
          equals(Left(ApiFailure(
              statusCode: fakeApiException.statusCode,
              message: fakeApiException.message))));

      verify(() => dataSource.getUsers()).called(1);
      verifyNoMoreInteractions(dataSource);
    });
  });
}

const fakeCreatedAt = '_whatever.createdAt';
const fakeName = '_whatever.name';
const fakeAvatar = '_whatever.avatar';

const fakeApiException =
    ApiException(statusCode: 500, message: 'Unknown Error Occurred');
