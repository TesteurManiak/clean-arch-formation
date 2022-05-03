import '../../core/platform/http_client.dart';
import '../models/user_model.dart';

abstract class RemoteDataSource {
  Future<UserModel?> getRandomUser();
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final HttpClient _client;

  RemoteDataSourceImpl({required HttpClient client}) : _client = client;

  @override
  Future<UserModel?> getRandomUser() async {
    final data =
        await _client.get<Map<String, dynamic>>('https://randomuser.me/api/');
    if (data == null) return null;
    return UserModel.fromJson(
      (data['results'] as Iterable).cast<Map<String, dynamic>>().first,
    );
  }
}
