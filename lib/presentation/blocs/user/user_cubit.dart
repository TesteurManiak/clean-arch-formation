import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/usecases/get_random_user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetRandomUser _getRandomUser;

  UserCubit({required GetRandomUser getRandomUser})
      : _getRandomUser = getRandomUser,
        super(const UserInitial());

  Future<void> fetchRandomUser() async {
    emit(const UserLoading());
    try {
      final user = await _getRandomUser();

      if (user == null) {
        emit(const NoUser());
      } else {
        emit(UserLoaded(user: user));
      }
    } catch (e) {
      emit(UserError(message: e.toString()));
    }
  }
}
