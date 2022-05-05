import 'package:clean_arch_formation/data/datasources/local_datasource.dart';
import 'package:clean_arch_formation/data/datasources/platform/network_info.dart';
import 'package:clean_arch_formation/data/datasources/remote_datasource.dart';
import 'package:clean_arch_formation/data/models/user_model.dart';
import 'package:clean_arch_formation/data/repositories/user_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockRemoteDataSource extends Mock implements RemoteDataSource {}

class MockLocalDataSource extends Mock implements LocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

void main() {
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late UserRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();

    repository = UserRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  group('UserRepositoryImpl', () {
    group('fetchRandomUser', () {
      const tUser = UserModel(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        thumbnailUrl: 'https://randomuser.me/api/portraits/thumb/',
      );

      test('should check if user is connected', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getRandomUser).thenAnswer((_) async => null);

        // act
        await repository.fetchRandomUser();

        // assert
        verify(mockNetworkInfo.isConnected);
      });

      test(
        'should call getRandomUser from remote datasource if connected',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getRandomUser)
              .thenAnswer((_) async => null);

          // act
          await repository.fetchRandomUser();

          // assert
          verify(mockRemoteDataSource.getRandomUser);
        },
      );

      test(
        'should call saveUser from local datasource if remote data not null',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
          when(mockRemoteDataSource.getRandomUser)
              .thenAnswer((_) async => tUser);
          when(() => mockLocalDataSource.saveUser(tUser))
              .thenAnswer((_) async => true);

          // act
          await repository.fetchRandomUser();

          // assert
          verify(() => mockLocalDataSource.saveUser(tUser));
        },
      );

      test(
        'should call getLastUser from local datasource if connected',
        () async {
          // arrange
          when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);
          when(mockLocalDataSource.getLastUser).thenAnswer((_) async => null);

          // act
          await repository.fetchRandomUser();

          // assert
          verify(mockLocalDataSource.getLastUser);
        },
      );
    });
  });
}
