import 'dart:convert';

import 'package:clean_arch_formation/data/datasources/platform/http_client.dart';
import 'package:clean_arch_formation/data/datasources/remote_datasource.dart';
import 'package:clean_arch_formation/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../utils/fixture.dart';

class MockHttpClient extends Mock implements HttpClient {}

void main() {
  late MockHttpClient mockHttpClient;
  late RemoteDataSourceImpl datasource;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = RemoteDataSourceImpl(client: mockHttpClient);
  });

  group('RemoteDataSourceImpl', () {
    group('getRandomUser', () {
      const tUrl = 'https://randomuser.me/api/';

      final tJson =
          jsonDecode(fixture('random_user.json')) as Map<String, dynamic>;
      final tUser = UserModel.fromJson(
        (tJson['results'] as Iterable).cast<Map<String, dynamic>>().first,
      );

      test('should call get method from http client', () async {
        // arrange
        when(
          () => mockHttpClient.get<Map<String, dynamic>>(tUrl),
        ).thenAnswer((_) async => null);

        // act
        await datasource.getRandomUser();

        // assert
        verify(() => mockHttpClient.get<Map<String, dynamic>>(tUrl));
      });

      test('if response is valid, should parse a UserModel', () async {
        // arrange
        when(
          () => mockHttpClient.get<Map<String, dynamic>>(tUrl),
        ).thenAnswer((_) async => tJson);

        // act
        final result = await datasource.getRandomUser();

        // assert
        expect(result, tUser);
      });
    });
  });
}
