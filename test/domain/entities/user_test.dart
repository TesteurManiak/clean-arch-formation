import 'dart:convert';

import 'package:clean_arch_formation/domain/entities/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    const tUser = User(
      id: '1',
      name: 'John Doe',
      email: 'johndoe@example.com',
      thumbnailUrl: 'https://randomuser.me/api/portraits/thumb/',
    );

    final tJson = {
      'login': {'uuid': tUser.id},
      'name': {'first': 'John', 'last': 'Doe'},
      'email': tUser.email,
      'picture': {'thumbnail': tUser.thumbnailUrl},
    };
    final tRawJson = jsonEncode(tJson);

    group('toJson', () {
      test('convert tUser to json', () {
        final json = tUser.toJson();
        expect(json, tJson);
      });
    });

    group('toRawJson', () {
      test('convert tUser to raw json', () {
        final json = tUser.toRawJson();
        expect(json, tRawJson);
      });
    });

    group('toString', () {
      test('toString should return same result as toRawJson', () {
        final json = tUser.toString();
        expect(json, tRawJson);
      });
    });
  });
}
