import 'package:clean_arch_formation/data/datasources/platform/http_client.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late DioClient client;

  setUp(() {
    mockDio = MockDio();
    client = DioClient(mockDio);
  });

  group('DioClient', () {
    group('get', () {
      const tUrl = 'https://example.com';

      final tResponse = Response<String>(
        requestOptions: RequestOptions(path: ''),
      );

      test('should call get from dio', () async {
        // arrange
        when(() => mockDio.get<String>(tUrl))
            .thenAnswer((_) async => tResponse);

        // act
        await client.get<String>(tUrl);

        // assert
        verify(() => mockDio.get<String>(tUrl));
      });
    });
  });
}
