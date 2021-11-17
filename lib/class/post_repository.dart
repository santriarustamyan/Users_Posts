import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:users_posts_project/model/post/post_comments.dart';
import 'package:users_posts_project/model/post/post_info.dart';

class PostRepository {
  Future<List<PostInfo>> getPost(int userId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      headers: <String, String>{'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final a = parsed
          .map<PostInfo>((json) => PostInfo.fromJson(json))
          .where((i) => i.userId == userId)
          .toList();

      return a;
    } else {
      throw Exception('Failed to update a case');
    }
  }

  Future<List<Comments>> getComments(int postId) async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/comments?postId=$postId'),
      headers: <String, String>{'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      final parsed = jsonDecode(response.body);
      final a =
          parsed.map<Comments>((json) => Comments.fromJson(json)).toList();

      return a;
    } else {
      throw Exception('Failed to update a case');
    }
  }
}
