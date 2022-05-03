import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String name;
  final String email;
  final String thumbnailUrl;

  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.thumbnailUrl,
  });

  @override
  List<Object?> get props => [id, name, email, thumbnailUrl];

  Map<String, dynamic> toJson() {
    final names = name.split(' ');
    return {
      'login': {'uuid': id},
      'name': {'first': names.first, 'last': names.last},
      'email': email,
      'picture': {'thumbnail': thumbnailUrl},
    };
  }

  String toRawJson() => jsonEncode(toJson());

  @override
  String toString() => toRawJson();
}
