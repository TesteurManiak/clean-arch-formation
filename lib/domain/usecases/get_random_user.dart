import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetRandomUser {
  final UserRepository _userRepository;

  GetRandomUser(this._userRepository);

  Future<User> call() => _userRepository.getRandomUser();
}
