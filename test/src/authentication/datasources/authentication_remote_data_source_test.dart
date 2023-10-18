import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:tdd_flutter_sample/core/errors/exceptions.dart';
import 'package:tdd_flutter_sample/core/utils/constants.dart';
import 'package:tdd_flutter_sample/src/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:tdd_flutter_sample/src/authentication/data/models/user_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client client;
  late AuthenticationRemoteDataSource remoteDataSource;

  setUp(() {
    client = MockHttpClient();
    remoteDataSource = AuthenticationRemoteDataSourceImpl(client);
    registerFallbackValue(Uri());
  });

  group('createUser', () {
    test(
      'should complete successfully when the status code is 200 or 201',
      () async {
        when(() => client.post(
                  Uri.https(baseUrl, kCreateUserEndpoint),
                  body: any(named: 'body'),
                  headers: any(named: 'headers'),
                ))
            .thenAnswer((_) async =>
                http.Response('{"message": "User created successfully"}', 200));

        await remoteDataSource.createUser(
          avatar: 'avatar',
          createdAt: 'createdAt',
          name: 'name',
        );

        // expect(
        //   () async => methodCall(
        //     avatar: 'avatar',
        //     createdAt: 'createdAt',
        //     name: 'name',
        //   ),
        //   completes,
        // );

        verify(
          () => client.post(Uri.https(baseUrl, kCreateUserEndpoint),
              body: jsonEncode({
                'createdAt': 'createdAt',
                'name': 'name',
                'avatar': 'avatar',
              }),
              headers: {'Content-Type': 'application/json'}),
        ).called(1);

        verifyNoMoreInteractions(client);
      },
    );

    test('should throw an ApiException with the correct message when status code is not 200', () async {
      // Arrange
      const createdAt = '2023-10-18';
      const name = 'Test User';
      const avatar = 'test_avatar_url';

      when(() => client.post(
        Uri.https(baseUrl, kCreateUserEndpoint),
        body: any(named: 'body'),
        headers: any(named: 'headers'),
      )).thenAnswer((_) async => http.Response('User creation failed', 400));

      // Act and Assert
      expect(
            () => remoteDataSource.createUser(createdAt: createdAt, name: name, avatar: avatar),
        throwsA(
          isA<ApiException>()
              .having((e) => e.message, 'message', 'User creation failed') // Adjust the message as needed
              .having((e) => e.statusCode, 'statusCode', 400),
        ),
      );
    });

  });

  group('getUsers', () {
    final tUsers = [
      UserModel(createdAt: '', name: 'Pablo', avatar: '', id: '1')
    ];
    test(
      'should return [List<User>] when the status code is 200',
      () async {
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(jsonEncode([tUsers.first.toMap()]), 200),
        );

        final result = await remoteDataSource.getUsers();

        expect(result, equals(tUsers));

        verify(() => client.get(Uri.https(baseUrl, kGetUsersEndpoint)))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );
    test(
      'should throw [APIException] when the status code is not 200',
      () async {
        const tMessage = 'Server down, Server '
            'down, I repeat Server down. Mayday Mayday Mayday, We are'
            ' going down, '
            'AHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH'
            'HHHH';
        when(() => client.get(any())).thenAnswer(
          (_) async => http.Response(
            tMessage,
            500,
          ),
        );

        final methodCall = remoteDataSource.getUsers;

        expect(
          () => methodCall(),
          throwsA(
            const ApiException(message: tMessage, statusCode: 500),
          ),
        );

        verify(() => client.get(Uri.https(baseUrl, kGetUsersEndpoint)))
            .called(1);
        verifyNoMoreInteractions(client);
      },
    );
  });
}
