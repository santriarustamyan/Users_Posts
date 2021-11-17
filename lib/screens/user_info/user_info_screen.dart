import 'package:flutter/material.dart';
import 'package:users_posts_project/class/album_repository.dart';
import 'package:users_posts_project/class/post_repository.dart';
import 'package:users_posts_project/model/album/album_info.dart';
import 'package:users_posts_project/model/post/post_info.dart';
import 'package:users_posts_project/model/users/user_info.dart';
import 'package:users_posts_project/widgets/richText_Widget.dart';
import 'package:users_posts_project/screens/view_all_albums/all_albums_screen.dart';
import 'package:users_posts_project/screens/view_all_posts/all_posts_screen.dart';

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
            Container(child: Text("NAME:")),
            RichTextWidget(
              text: ("${_userInfo!.name}"),
              color: Colors.blue,
            ),
            Container(child: Text("EMAIL:")),
            RichTextWidget(
              text: ("${_userInfo!.email}"),
              color: Colors.blue,
            ),
            Container(child: Text("PHONE:")),
            RichTextWidget(
              text: ("${_userInfo!.phone}"),
              color: Colors.blue,
            ),
            Container(child: Text("WEB Site:")),
            RichTextWidget(
              text: ("${_userInfo!.website}"),
              color: Colors.blue,
            ),
            Container(child: Text("NAME:")),
            RichTextWidget(
              text: ("${_userInfo!.company!.name}"),
              color: Colors.blue,
            ),
            Container(child: Text("BS:")),
            RichTextWidget(
              text: ("${_userInfo!.company!.bs}"),
              color: Colors.blue,
            ),
            Container(child: Text("Catch Phrase:")),
            RichTextWidget(
              text: ("${_userInfo!.company!.catchPhrase}"),
              color: Colors.blue,
            ),
            Container(child: Text("Info About Address:")),
            RichTextWidget(
              text:
                  ("city ${_userInfo!.address!.city} street ${_userInfo!.address!.street} suite ${_userInfo!.address!.suite}\nzipcode ${_userInfo!.address!.zipcode}\nlat ${_userInfo!.address!.geo!.lat} lng ${_userInfo!.address!.geo!.lng}"),
              color: Colors.blue,
            ),
            Padding(
                padding: EdgeInsets.only(top: 15),
                child: Column(children: [
                  for (int i = 0; i < posts.length && i < 3; i++)
                    Container(child: Text("${i + 1}${posts[i].title}")),
                  TextButton(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AllPostsScreen(userId: _userInfo!.id!))),
                      child: Text("{ViewAllPosts}")),
                ])),
            Column(children: [
              for (int i = 0; i < album.length && i < 3; i++)
                Container(child: Text("${i + 1}${album[i].title}")),
              TextButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              AllAlbumsScreen(userId: _userInfo!.id!))),
                  child: Text("{ViewAllAlboms}")),
            ])
          ],
        )));
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
