import 'package:clean_arch_formation/data/datasources/platform/network_info.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConnectivity extends Mock implements Connectivity {}

void main() {
  late MockConnectivity mockConnectivity;
  late NetworkInfoImpl networkInfo;

  setUp(() {
    mockConnectivity = MockConnectivity();
    networkInfo = NetworkInfoImpl(mockConnectivity);
  });

  group('NetworkInfoImpl', () {
    group('isConnected', () {
      test('should call checkConnectivity', () async {
        // arrange
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.mobile);

        // act
        await networkInfo.isConnected();

        // assert
        verify(() => mockConnectivity.checkConnectivity());
      });
    });

    test(
      'should return true when ConnectivityResult is mobile',
      () async {
        // arrange
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.mobile);

        // act
        final result = await networkInfo.isConnected();

        // assert
        expect(result, true);
      },
    );

    test(
      'should return true when ConnectivityResult is wifi',
      () async {
        // arrange
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.wifi);

        // act
        final result = await networkInfo.isConnected();

        // assert
        expect(result, true);
      },
    );

    test(
      'should return false for any other ConnectivityResult',
      () async {
        // arrange
        when(() => mockConnectivity.checkConnectivity())
            .thenAnswer((_) async => ConnectivityResult.none);

        // act
        final result = await networkInfo.isConnected();

        // assert
        expect(result, false);
      },
    );
  });
}
