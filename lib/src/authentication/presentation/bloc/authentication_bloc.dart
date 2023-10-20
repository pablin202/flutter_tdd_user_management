import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/create_user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/usecases/get_users.dart';

import '../../domain/entities/user.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc(
      {required CreateUser createUser, required GetUsers getUsers})
      : _createUser = createUser,
        _getUsers = getUsers,
        super(const AuthenticationInitial()) {
    on<CreateUserEvent>(_createUserHandler);
    on<GetUserEvent>(_getUsersHandler);
  }

  final CreateUser _createUser;
  final GetUsers _getUsers;

  Future<void> _createUserHandler(
      CreateUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const CreatingUser());
    final result = await _createUser(CreateUserParams(
        createdAt: event.createdAt, name: event.name, avatar: event.avatar));

    result.fold((failure) => emit(AuthenticationError(failure.toString())),
        (_) => emit(const UserCreated()));
  }

  Future<void> _getUsersHandler(
      GetUserEvent event, Emitter<AuthenticationState> emit) async {
    emit(const GettingUsers());
    final result = await _getUsers();
    result.fold((failure) => emit(AuthenticationError(failure.toString())),
        (users) => emit(UsersLoaded(users)));
  }
}
