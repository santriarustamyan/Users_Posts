import 'package:flutter/material.dart';
import 'package:users_posts_project/class/post_repository.dart';
import 'package:users_posts_project/model/post/post_comments.dart';

class PostInfoScreen extends StatefulWidget {
  PostInfoScreen({required this.postId});
  final int? postId;

  @override
  _PostInfoScreenState createState() => _PostInfoScreenState();
}

class _PostInfoScreenState extends State<PostInfoScreen> {
  int? get _postId => widget.postId;

  late List<Comments> comments;

  PostRepository get postRepository => _postRepository;
  PostRepository _postRepository = PostRepository();

  @override
  void initState() {
    super.initState();
    comments = [];

    getComments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          title: Text("COMMENTS"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            for (int i = 0; i < comments.length; i++)
              Text("${comments[i].body}"),
          ]),
        ));
  }

  Future<void> getComments() async {
    comments.addAll(await postRepository.getComments(_postId!));
    setState(() {
      comments = comments;
    });
  }
}
