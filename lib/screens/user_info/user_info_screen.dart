import 'package:flutter/material.dart';
import 'package:users_posts_project/class/album_repository.dart';
import 'package:users_posts_project/class/post_repository.dart';
import 'package:users_posts_project/model/album/album_info.dart';
import 'package:users_posts_project/model/post/post_info.dart';
import 'package:users_posts_project/model/users/user_info.dart';
import 'package:users_posts_project/screens/view_all_albums/all_albums_screen.dart';
import 'package:users_posts_project/screens/view_all_posts/all_posts_screen.dart';
import 'package:users_posts_project/widgets/table_widget.dart';

class UserInfoScreen extends StatefulWidget {
  UserInfoScreen({required this.user});
  final UserInfo? user;
  @override
  _UserInfoScreenState createState() => _UserInfoScreenState();
}

class _UserInfoScreenState extends State<UserInfoScreen> {
  UserInfo? get _userInfo => widget.user;

  late List<PostInfo> posts;
  late List<AlbumInfo> album;
  AlbumRepository get albumRepository => _albumRepository;
  AlbumRepository _albumRepository = AlbumRepository();

  PostRepository get postRepository => _postRepository;
  PostRepository _postRepository = PostRepository();

  @override
  void initState() {
    super.initState();
    album = [];
    posts = [];
    getPost();
    getAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text("${_userInfo!.username!}"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            TableWidget(text1: "NAME:", text2: "${_userInfo!.name}"),
            TableWidget(text1: "EMAIL:", text2: "${_userInfo!.email}"),
            TableWidget(text1: "PHONE:", text2: "${_userInfo!.phone}"),
            TableWidget(text1: "WEB Site:", text2: "${_userInfo!.website}"),
            TableWidget(
                text1: "COMPANY NAME:", text2: "${_userInfo!.company!.name}"),
            TableWidget(text1: "BS:", text2: "${_userInfo!.company!.bs}"),
            TableWidget(
                text1: "Catch Phrase:",
                text2: "${_userInfo!.company!.catchPhrase}"),
            TableWidget(
              text1: "Info About Address:",
              text2:
                  "city ${_userInfo!.address!.city} street ${_userInfo!.address!.street} suite ${_userInfo!.address!.suite}\nzipcode ${_userInfo!.address!.zipcode}\nlat ${_userInfo!.address!.geo!.lat} lng ${_userInfo!.address!.geo!.lng}",
            ),
            _post(),
            _albom()
          ],
        )));
  }

  Widget _post() {
    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Column(children: [
          Text("POSTS",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 20,
              )),
          for (int i = 0; i < posts.length && i < 3; i++)
            TableWidget(
              text1: "${i + 1}",
              text2: "${posts[i].title}",
            ),
          TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AllPostsScreen(userId: _userInfo!.id!))),
              child: Text("ViewAllPosts")),
        ]));
  }

  Widget _albom() {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        child: Column(children: [
          Text("ALBUM",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.amber,
                fontSize: 20,
              )),
          for (int i = 0; i < album.length && i < 3; i++)
            TableWidget(
              text1: "${i + 1}",
              text2: "${album[i].title}",
            ),
          TextButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          AllAlbumsScreen(userId: _userInfo!.id!))),
              child: Text("ViewAllAlboms")),
        ]));
  }

  Future<void> getPost() async {
    posts.addAll(await postRepository.getPost(_userInfo!.id!));
    setState(() {
      posts = posts;
    });
  }

  Future<void> getAlbum() async {
    album.addAll(await albumRepository.getAlbum(_userInfo!.id!));
    setState(() {
      album = album;
    });
  }
}
