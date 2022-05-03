import 'dart:convert';

import 'package:clean_arch_formation/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../utils/fixture.dart';

void main() {
  group('UserModel', () {
    group('fromJson', () {
      const tUser = UserModel(
        id: 'befd0dba-d344-4195-a330-dc002b8b1645',
        name: 'Molly Tucker',
        email: 'molly.tucker@example.com',
        thumbnailUrl: 'https://randomuser.me/api/portraits/thumb/women/15.jpg',
      );

      final tFile = ((jsonDecode(fixture('random_user.json'))
              as Map<String, dynamic>)['results'] as Iterable)
          .cast<Map<String, dynamic>>()
          .first;

      test('parse file: random_user.json', () {
        final userModel = UserModel.fromJson(tFile);
        expect(userModel, tUser);
      });
    });
  });
}
