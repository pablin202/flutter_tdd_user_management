import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_flutter_sample/core/utils/typedef.dart';
import 'package:tdd_flutter_sample/src/authentication/data/models/user_model.dart';
import '../../../../fixtures/fixture_reader.dart';

void main() {

  final tJson = fixture('test/fixtures/user.json');
  final tMap = jsonDecode(tJson) as DataMap;

  group('fromMap', () {
    test('should return a [UserModel] with the right data', () {
      // Arrange

      // Act
      final result = UserModel.fromMap(tMap);
      
      // Assert
      expect(result, equals(userModelEmpty));
    });
  });

  group('fromJson', () {
    test('should return a [UserModel] with the right data', () {
      // Arrange

      // Act
      final result = UserModel.fromJson(tJson);

      // Assert
      expect(result, equals(userModelEmpty));
    });
  });

  group('toMap', () {
    test('should return a [Map<String,dynamic>] with the right data', () {
      // Arrange

      // Act
      final result = userModelEmpty.toMap();

      // Assert
      expect(result, equals(tMap));
    });
  });

  group('toJson', () {
    test('should return a [Json] with the right data', () {
      // Arrange

      // Act
      final result = userModelEmpty.toJson();
      final tJson = jsonEncode({
        "createdAt": "_empty.createdAt",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "id": "1"
      });
      // Assert
      expect(result, tJson);
    });
  });

  group('copyWith', () {
    test('should return a [UserModel] with different data', () {
      // Arrange

      // Act
      final result = userModelEmpty.copyWith(name: 'Paul');
      // Assert
      expect(result.name, equals('Paul'));
      expect(result.avatar, equals(userModelEmpty.avatar));
    });
  });

}

final userModelEmpty = UserModel(
    createdAt: '_empty.createdAt',
    name: '_empty.name',
    avatar: '_empty.avatar',
    id: '1');
