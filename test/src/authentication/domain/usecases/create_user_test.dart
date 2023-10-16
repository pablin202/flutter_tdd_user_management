import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/create_user.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late CreateUser usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = CreateUser(repository);
  });

  test('should call the [Repository.createUser]', () async {
    // Arrange
    when(() => repository.createUser(
            createdAt: any(named: 'createdAt'),
            name: any(named: 'name'),
            avatar: any(named: 'avatar')))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(fakeParams);

    // Assert
    expect(result, equals(const Right<dynamic, void>(null)));
    verify(() => repository.createUser(
        createdAt: fakeParams.createdAt,
        name: fakeParams.name,
        avatar: fakeParams.avatar)).called(1);
    verifyNoMoreInteractions(repository);
  });
}

const fakeParams = CreateUserParams(
    createdAt: 'createdAt', name: 'John', avatar: 'https://image.png');
