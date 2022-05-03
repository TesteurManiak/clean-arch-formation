import '../../core/platform/http_client.dart';

abstract class RemoteDataSource {}

class RemoteDataSourceImpl implements RemoteDataSource {
  final HttpClient _client;

  RemoteDataSourceImpl({required HttpClient client}) : _client = client;
}
