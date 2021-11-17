import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_posts_project/model/users/user_info.dart';
import 'package:users_posts_project/screens/user_info/user_info_screen.dart';
import 'all_users_cubit.dart';
import 'all_users_state.dart';

class AllUserScreen extends StatefulWidget {
  @override
  _AllUserScreenState createState() => _AllUserScreenState();
}

class _AllUserScreenState extends State<AllUserScreen> {
  // double get _deviceSize => MediaQuery.of(context).size.width;

  late List<UserInfo> _users;

  late AllUserCubit _allUserCubit;
  @override
  void initState() {
    super.initState();
    _users = [];
    _allUserCubit = AllUserCubit();
    _allUserCubit.getAllUser();
  }

  @override
  void dispose() {
    _allUserCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AllUserCubit>(
        create: (context) {
          return _allUserCubit;
        },
        child: BlocListener<AllUserCubit, AllUserState>(
          listener: _blocListner,
          child: _build(context),
        ));
  }

  void _blocListner(context, state) {
    if (state is AllUsersState) {
      _users = state.users;
      setState(() {});
    }
  }

  Widget _build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Stack(children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: 80,
            bottom: 40,
          ),
          child: Column(
            children: [
              Row(children: [
                Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.center, child: Text("NAME"))),
                Expanded(
                    flex: 1,
                    child: Container(
                        alignment: Alignment.center, child: Text("USERNAME"))),
              ]),
              for (var i = 0; i < _users.length; i++) _viewUserButton(i),
            ],
          ),
        ),
      ]),
    ));
  }

  Widget _viewUserButton(i) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
              alignment: Alignment.center,
              child: TextButton(
                child: Text(" ${_users[i].name}"),
                onPressed: () async {
                  _viewUserAction(_users[i]);
                },
              )),
        ),
        Expanded(
          flex: 1,
          child: Container(
              alignment: Alignment.center,
              child: TextButton(
                child: Text("${_users[i].username}"),
                onPressed: () async {
                  _viewUserAction(_users[i]);
                },
              )),
        )
      ],
    );
  }

  void _viewUserAction(UserInfo _user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserInfoScreen(user: _user)));
  }
}
