import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/local_datasource.dart';
import '../datasources/platform/network_info.dart';
import '../datasources/remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  UserRepositoryImpl({
    required RemoteDataSource remoteDataSource,
    required LocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;

  @override
  Future<User?> fetchRandomUser() async {
    final isConnected = await _networkInfo.isConnected();
    if (isConnected) {
      final user = await _remoteDataSource.getRandomUser();
      if (user != null) {
        await _localDataSource.saveUser(user);
      }
      return user;
    }
    return _localDataSource.getLastUser();
  }
}
