import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_posts_project/class/user_repository.dart';
import 'package:users_posts_project/model/users/user_info.dart';

import 'all_users_state.dart';

class AllUserCubit extends Cubit<AllUserState> {
  AllUserCubit() : super(AllUserInitialState());

  UserRepository get userRepository => _userRepository;
  UserRepository _userRepository = UserRepository();

  Future<void> getAllUser() async {
    final List<UserInfo> _users = await userRepository.getUser();

    emit(AllUsersState(users: _users));
  }
}
