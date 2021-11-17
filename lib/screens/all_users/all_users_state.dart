import 'package:equatable/equatable.dart';
import 'package:users_posts_project/model/users/user_info.dart';

abstract class AllUserState extends Equatable {
  const AllUserState();

  @override
  List<Object> get props => [];
}

class AllUserInitialState extends AllUserState {}

class AllUsersState extends AllUserState {
  final List<UserInfo> users;
  AllUsersState({required this.users});

  @override
  List<Object> get props => [users];
}
