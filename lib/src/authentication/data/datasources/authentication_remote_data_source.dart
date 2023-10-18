import 'dart:convert';

import 'package:tdd_flutter_sample/core/errors/exceptions.dart';
import 'package:tdd_flutter_sample/src/authentication/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../core/utils/constants.dart';
import '../../../../core/utils/typedef.dart';

abstract class AuthenticationRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<void> createUser(
      {required String createdAt,
      required String name,
      required String avatar});
}

const kCreateUserEndpoint = '/test-api/users';
const kGetUsersEndpoint = '/test-api/users';

class AuthenticationRemoteDataSourceImpl
    extends AuthenticationRemoteDataSource {
  final http.Client _client;

  AuthenticationRemoteDataSourceImpl(this._client);

  @override
  Future<void> createUser({
    required String createdAt,
    required String name,
    required String avatar,
  }) async {
    // 1. check to make sure that it returns the right data when the status
    // code is 200 or the proper response code
    // 2. check to make sure that it "THROWS A CUSTOM EXCEPTION" with the
    // right message when status code is the bad one
    try {
      final response = await _client.post(
          Uri.https(baseUrl, kCreateUserEndpoint),
          body: jsonEncode({
            'createdAt': createdAt,
            'name': name,
            'avatar': avatar,
          }),
          headers: {
            'Content-Type': 'application/json'
          }
      );
      if (response.statusCode != 200 && response.statusCode != 201) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }


  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final response = await _client.get(
        Uri.https(baseUrl, kGetUsersEndpoint),
      );
      if (response.statusCode != 200) {
        throw ApiException(
          message: response.body,
          statusCode: response.statusCode,
        );
      }
      return List<DataMap>.from(jsonDecode(response.body) as List)
          .map((userData) => UserModel.fromMap(userData))
          .toList();
    } on ApiException {
      rethrow;
    } catch (e) {
      throw ApiException(message: e.toString(), statusCode: 505);
    }
  }
}
