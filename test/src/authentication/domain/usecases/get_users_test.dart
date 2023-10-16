import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/entities/user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/repositories/authentication_repository.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/get_users.dart';

class MockAuthRepo extends Mock implements AuthenticationRepository {}

void main() {
  late GetUsers usecase;
  late AuthenticationRepository repository;

  setUp(() {
    repository = MockAuthRepo();
    usecase = GetUsers(repository);
  });

  test('should call the [Repository.getUsers] and return [List<User>]', () async {
    // Arrange
    when(() => repository.getUsers()).thenAnswer((_) async => const Right(fakeUserList));

    // Act
    final result = await usecase();

    // Assert
    expect(result, equals(const Right<dynamic, List<User>>(fakeUserList)));
    verify(() => repository.getUsers()).called(1);
    verifyNoMoreInteractions(repository);
  });
}

const fakeUserList = [
  User(id: 1, createdAt: 'createdAt', name: 'name', avatar: 'avatar')
];
