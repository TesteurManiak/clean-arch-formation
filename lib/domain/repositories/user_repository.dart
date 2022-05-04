import '../entities/user.dart';

abstract class UserRepository {
  /// If connected to internet, fetch data from remote data source.
  ///
  /// If not, return the latest received user from local data source.
  ///
  /// This method will return a `null` value if there is no internet connection
  /// and no local data previously saved.
  Future<User?> fetchRandomUser();
}
