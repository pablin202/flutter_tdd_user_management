import 'package:equatable/equatable.dart';
import 'package:tdd_flutter_sample/core/usecase/usercase.dart';
import 'package:tdd_flutter_sample/core/utils/typedef.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/repositories/authentication_repository.dart';

class CreateUser extends UseCaseWithParams<void, CreateUserParams> {
  final AuthenticationRepository _authenticationRepository;
  CreateUser(this._authenticationRepository);

  @override
  ResultVoid call(params)
    async =>
        _authenticationRepository.createUser(
            createdAt: params.createdAt, name: params.name, avatar: params.avatar);

}

class CreateUserParams extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;

  const CreateUserParams({required this.createdAt, required this.name, required this.avatar});

  @override
  List<Object?> get props => [createdAt, name, avatar];
}