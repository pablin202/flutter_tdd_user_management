import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter_sample/core/errors/failure.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/entities/user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/get_users.dart';
import 'package:tdd_flutter_sample/src/authentication/presentation/cubit/authentication_cubit.dart';

class MockGetUsers extends Mock implements GetUsers {}

class MockCreateUser extends Mock implements CreateUser {}

void main() {
  late GetUsers getUsers;
  late CreateUser createUser;
  late AuthenticationCubit cubit;

  setUp(() {
    getUsers = MockGetUsers();
    createUser = MockCreateUser();
    cubit = AuthenticationCubit(createUser: createUser, getUsers: getUsers);
    registerFallbackValue(userParams);
  });

  tearDown(() => cubit.close());

  test('initial state should be [AuthenticationInitial]', () async {
    expect(cubit.state, const AuthenticationInitial());
  });

  group('createUser', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [CreatingUser, UserCreated] when successful',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.createUser('createdAt', 'name', 'avatar'),
        expect: () => [const CreatingUser(), const UserCreated()],
        verify: (_) {
          verify(() => createUser(userParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [CreatingUser, AuthenticationError] when unsuccessful',
        build: () {
          when(() => createUser(any()))
              .thenAnswer((_) async => const Left(fakeFailure));
          return cubit;
        },
        act: (cubit) => cubit.createUser('createdAt', 'name', 'avatar'),
        expect: () =>
            [const CreatingUser(), AuthenticationError(fakeFailure.toString())],
        verify: (_) {
          verify(() => createUser(userParams)).called(1);
          verifyNoMoreInteractions(createUser);
        });
  });

  group('getUsers', () {
    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [GettingUsers, UsersLoaded] when successful',
        build: () {
          when(() => getUsers()).thenAnswer((_) async => const Right(users));
          return cubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () => [const GettingUsers(), const UsersLoaded(users)],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });

    blocTest<AuthenticationCubit, AuthenticationState>(
        'should emit [GettingUsers, AuthenticationError] when unsuccessful',
        build: () {
          when(() => getUsers())
              .thenAnswer((_) async => const Left(fakeFailure));
          return cubit;
        },
        act: (cubit) => cubit.getUsers(),
        expect: () =>
            [const GettingUsers(), AuthenticationError(fakeFailure.toString())],
        verify: (_) {
          verify(() => getUsers()).called(1);
          verifyNoMoreInteractions(getUsers);
        });
  });
}

const List<User> users = [
  User(id: '1', createdAt: 'createdAt', name: 'name', avatar: 'avatar')
];

const ApiFailure fakeFailure =
    ApiFailure(statusCode: 400, message: 'unknown error');

const CreateUserParams userParams =
    CreateUserParams(createdAt: 'createdAt', name: 'name', avatar: 'avatar');
