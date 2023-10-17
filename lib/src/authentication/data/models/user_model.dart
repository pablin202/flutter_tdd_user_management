import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:tdd_flutter_sample/core/utils/typedef.dart';

/// createdAt : "2023-10-16T13:22:59.077Z"
/// name : "Frances Emmerich"
/// avatar : "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1101.jpg"
/// id : "1"

class UserModel extends Equatable {
  final String createdAt;
  final String name;
  final String avatar;
  final String id;

  UserModel(
      {required this.createdAt,
      required this.name,
      required this.avatar,
      required this.id});

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(jsonDecode(source) as DataMap);

  UserModel.fromMap(DataMap map)
      : this(
            avatar: map['avatar'] as String,
            id: map['id'] as String,
            name: map['name'] as String,
            createdAt: map['createdAt'] as String);

  UserModel copyWith({
    String? createdAt,
    String? name,
    String? avatar,
    String? id,
  }) {
    return UserModel(
      createdAt: createdAt ?? this.createdAt,
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      id: id ?? this.id,
    );
  }

  DataMap toMap() =>
      {'createdAt': createdAt, 'name': name, 'avatar': avatar, 'id': id};

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props => [id, name, avatar];
}
