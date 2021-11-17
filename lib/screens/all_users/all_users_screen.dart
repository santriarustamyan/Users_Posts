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
  double get _deviceSizeWidth => MediaQuery.of(context).size.width;

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
        Padding(
          padding: const EdgeInsets.only(
            top: 30,
            bottom: 10,
          ),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: _viewUserButton(),
              ),
              _viewTitle(),
            ],
          ),
        ),
      ]),
    ));
  }

  Widget _viewTitle() {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: Row(children: [
          Expanded(
              child: Container(
                  alignment: Alignment.topCenter, child: Text("NAME"))),
          Expanded(
              child: Container(
                  alignment: Alignment.topCenter, child: Text("USERNAME"))),
        ]));
  }

  void _viewUserAction(UserInfo _user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserInfoScreen(user: _user)));
  }

  Widget _viewUserButton() {
    return Padding(
        padding: EdgeInsets.only(top: 40),
        child: SingleChildScrollView(
          child: Table(
            columnWidths: {
              0: FixedColumnWidth(_deviceSizeWidth),
              1: FlexColumnWidth(),
            },
            children: _users.map((user) {
              return TableRow(children: [
                Container(
                    color: Colors.blue[50],
                    padding: EdgeInsets.all(15),
                    child: TextButton(
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(("${user.name}")),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: Text(("${user.username}")),
                            ),
                          )
                        ],
                      ),
                      onPressed: () async {
                        _viewUserAction(user);
                      },
                    )),
              ]);
            }).toList(),
            border: TableBorder.all(width: 1, color: Colors.blue),
          ),
        ));
  }
}
