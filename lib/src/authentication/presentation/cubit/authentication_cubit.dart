import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/get_users.dart';

import '../../domain/entities/user.dart';

part 'authentication_state.dart';

class AuthenticationCubit extends Cubit<AuthenticationState> {
  AuthenticationCubit(
      {required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial());

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> createUser(String createdAt, String name, String avatar) async {
    emit(const CreatingUser());
    final result = await _createUser(
        CreateUserParams(createdAt: createdAt, name: name, avatar: avatar));

    result.fold((failure) => emit(AuthenticationError(failure.toString())),
        (_) => emit(const UserCreated()));
  }

  Future<void> getUsers() async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold((failure) => emit(AuthenticationError(failure.toString())),
        (users) => emit(UsersLoaded(users)));
  }
}
