import 'package:flutter/material.dart';
import 'package:users_posts_project/class/post_repository.dart';
import 'package:users_posts_project/model/post/post_info.dart';
import 'package:users_posts_project/screens/post_info/post_info_screen.dart';
import 'package:users_posts_project/widgets/table_widget.dart';

class AllPostsScreen extends StatefulWidget {
  AllPostsScreen({required this.userId});
  final int userId;
  @override
  _AllPostsScreenState createState() => _AllPostsScreenState();
}

class _AllPostsScreenState extends State<AllPostsScreen> {
  double get _deviceSizeWidth => MediaQuery.of(context).size.width;

  int? get _userId => widget.userId;

  late List<PostInfo> posts;

  PostRepository get postRepository => _postRepository;
  PostRepository _postRepository = PostRepository();
  @override
  void initState() {
    super.initState();
    posts = [];
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("POSTS"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
          child: Column(children: [
        for (int i = 0; i < posts.length; i++)
          TextButton(
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        PostInfoScreen(postId: posts[i].id!))),
            child: TableWidget(
              text1: "${i + 1}",
              text2: "${posts[i].body}",
              sizeWidth: _deviceSizeWidth / 5,
            ),
          )
      ])),
    );
  }

  Future<void> getPost() async {
    posts.addAll(await postRepository.getPost(_userId!));
    setState(() {
      posts = posts;
    });
  }
}
