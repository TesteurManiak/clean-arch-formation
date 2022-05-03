import 'package:clean_arch_formation/domain/entities/user.dart';
import 'package:clean_arch_formation/domain/repositories/user_repository.dart';
import 'package:clean_arch_formation/domain/usecases/get_random_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockUserRepository extends Mock implements UserRepository {}

void main() {
  late MockUserRepository mockUserRepository;
  late GetRandomUser useCase;

  setUp(() {
    mockUserRepository = MockUserRepository();
    useCase = GetRandomUser(mockUserRepository);
  });

  group('GetRandomUser', () {
    const tUser = User(
      id: '1',
      name: 'John Doe',
      email: 'johndoe@example.com',
      thumbnailUrl: 'https://randomuser.me/api/portraits/thumb/',
    );

    test('should call fetchRandomUser from the repository', () async {
      //arrange
      when(mockUserRepository.fetchRandomUser).thenAnswer((_) async => null);

      //act
      await useCase();

      //assert
      verify(() => mockUserRepository.fetchRandomUser());
    });

    test('should return tUser', () async {
      //arrange
      when(() => mockUserRepository.fetchRandomUser())
          .thenAnswer((_) => Future.value(tUser));

      //act
      final user = await useCase();

      //assert
      expect(user, tUser);
    });
  });
}
