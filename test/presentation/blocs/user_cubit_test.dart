import 'package:bloc_test/bloc_test.dart';
import 'package:clean_arch_formation/domain/entities/user.dart';
import 'package:clean_arch_formation/domain/usecases/get_random_user.dart';
import 'package:clean_arch_formation/presentation/blocs/user/user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetRandomUser extends Mock implements GetRandomUser {}

void main() {
  late MockGetRandomUser mockGetRandomUser;
  late UserCubit userCubit;

  setUp(() {
    mockGetRandomUser = MockGetRandomUser();
    userCubit = UserCubit(getRandomUser: mockGetRandomUser);
  });

  group('UserCubit', () {
    group('fetchRandomUser', () {
      const tUser = User(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        thumbnailUrl: 'https://randomuser.me/api/portraits/thumb/',
      );

      final tException = Exception('error');

      test('should call GetRandomUser', () async {
        // arrange
        when(mockGetRandomUser.call).thenAnswer((_) async => tUser);

        // act
        await userCubit.fetchRandomUser();

        // assert
        verify(mockGetRandomUser.call);
      });

      blocTest<UserCubit, UserState>(
        'should emit [UserLoading, UserLoaded] when data is gotten successfully',
        build: () => userCubit,
        setUp: () {
          when(mockGetRandomUser.call).thenAnswer((_) async => tUser);
        },
        act: (cubit) => cubit.fetchRandomUser(),
        expect: () => const [
          UserLoading(),
          UserLoaded(user: tUser),
        ],
      );

      blocTest<UserCubit, UserState>(
        'should emit [UserLoading, NoUser] when received data is null',
        build: () => userCubit,
        setUp: () {
          when(mockGetRandomUser.call).thenAnswer((_) async => null);
        },
        act: (cubit) => cubit.fetchRandomUser(),
        expect: () => const [UserLoading(), NoUser()],
      );

      blocTest<UserCubit, UserState>(
        'should emit [UserLoading, UserError] when received data is null',
        build: () => userCubit,
        setUp: () {
          when(mockGetRandomUser.call).thenAnswer((_) => throw tException);
        },
        act: (cubit) => cubit.fetchRandomUser(),
        expect: () =>
            [const UserLoading(), UserError(message: tException.toString())],
      );
    });
  });
}
