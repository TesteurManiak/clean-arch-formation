import 'package:clean_arch_formation/data/datasources/local_datasource.dart';
import 'package:clean_arch_formation/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockSharedPreferences;

  late LocalDataSourceImpl datasource;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    datasource = LocalDataSourceImpl(sharedPreferences: mockSharedPreferences);
  });

  group('LocalDataSourceImpl', () {
    const tUser = UserModel(
      id: '1',
      name: 'John Doe',
      email: 'johndoe@example.com',
      thumbnailUrl: 'https://randomuser.me/api/portraits/thumb/',
    );

    group('getLastUser', () {
      test('should call getString', () async {
        // arrange
        when(() => mockSharedPreferences.getString('user'))
            .thenAnswer((_) => null);

        // act
        await datasource.getLastUser();

        // assert
        verify(() => mockSharedPreferences.getString('user'));
      });

      test(
        'if getString value not null, should parse a UserModel',
        () async {
          // arrange
          when(() => mockSharedPreferences.getString('user'))
              .thenAnswer((_) => tUser.toRawJson());

          // act
          final result = await datasource.getLastUser();

          // assert
          expect(result, tUser);
        },
      );
    });

    group('saveUser', () {
      test('should encode user and call setString', () async {
        // arrange
        when(() => mockSharedPreferences.setString('user', tUser.toRawJson()))
            .thenAnswer((_) async => true);

        // act
        await datasource.saveUser(tUser);

        // assert
        verify(
          () => mockSharedPreferences.setString('user', tUser.toRawJson()),
        );
      });
    });
  });
}
