import 'package:clean_arch_formation/domain/entities/user.dart';
import 'package:clean_arch_formation/presentation/blocs/user/user_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserState', () {
    group('props', () {
      const tUser = User(
        id: '1',
        name: 'John Doe',
        email: 'johndoe@example.com',
        thumbnailUrl: 'https://randomuser.me/api/portraits/thumb/',
      );

      test('default props returns empty list', () {
        expect(const UserInitial().props, isEmpty);
        expect(const UserLoading().props, isEmpty);
        expect(const NoUser().props, isEmpty);
      });

      test('UserLoaded props contains user', () {
        expect(const UserLoaded(user: tUser).props, [tUser]);
      });

      test('UserError props contains message', () {
        expect(const UserError(message: 'error').props, ['error']);
      });
    });
  });
}
