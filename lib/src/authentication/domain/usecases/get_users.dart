import 'package:tdd_flutter_sample/core/usecase/usercase.dart';
import 'package:tdd_flutter_sample/core/utils/typedef.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/entities/user.dart';
import 'package:tdd_flutter_sample/src/authentication/domain/repositories/authentication_repository.dart';

class GetUsers extends UseCaseWithoutParams<List<User>> {
  final AuthenticationRepository _authenticationRepository;
  GetUsers(this._authenticationRepository);

  @override
  ResultFuture<List<User>> call() async => _authenticationRepository.getUsers();
}
