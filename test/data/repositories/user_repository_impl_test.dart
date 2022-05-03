import 'package:clean_arch_formation/core/platform/network_info.dart';
import 'package:clean_arch_formation/data/datasources/local_datasource.dart';
import 'package:clean_arch_formation/data/datasources/remote_datasource.dart';
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
      test('should check if user is connected', () async {
        // arrange
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
        when(mockRemoteDataSource.getRandomUser).thenAnswer((_) async => null);

        // act
        await repository.fetchRandomUser();

        // assert
        verify(mockNetworkInfo.isConnected);
      });
    });
  });
}
